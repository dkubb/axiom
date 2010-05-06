require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction#optimize' do
  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }

  subject { restriction.optimize }

  describe 'with a true proposition' do
    let(:proposition) { relation[:id].eq(relation[:id])                 }
    let(:restriction) { Algebra::Restriction.new(relation, proposition) }

    it { should equal(relation) }
  end

  describe 'with a false proposition' do
    let(:proposition) { relation[:id].ne(relation[:id])                 }
    let(:restriction) { Algebra::Restriction.new(relation, proposition) }

    it { should eql(Relation::Empty.new(relation.header)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == restriction
    end
  end

  describe 'with a predicate' do
    let(:predicate)   { relation[:id].eq(1)                           }
    let(:restriction) { Algebra::Restriction.new(relation, predicate) }

    it { should equal(restriction) }
  end

  describe 'with an optimizable predicate' do
    let(:predicate)   { relation[:id].eq(1).and(Logic::Proposition::True.instance) }
    let(:restriction) { Algebra::Restriction.new(relation, predicate)              }

    it { should_not equal(restriction) }

    it { should be_instance_of(Algebra::Restriction) }

    it 'sets the predicate' do
      subject.predicate.should eql(relation[:id].eq(1))
    end

    its(:relation) { should equal(relation) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == restriction
    end
  end

  describe 'with an optimizable operation' do
    let(:predicate)   { relation[:id].eq(1)                             }
    let(:projection)  { relation.project(relation.header)               }
    let(:restriction) { Algebra::Restriction.new(projection, predicate) }

    it { should_not equal(restriction) }

    it { should be_instance_of(Algebra::Restriction) }

    it 'sets the predicate' do
      subject.predicate.should equal(predicate)
    end

    its(:relation) { should equal(relation) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == restriction
    end
  end

  describe 'with an empty relation' do
    let(:empty)       { Relation::Empty.new([ [ :id, Integer ] ])  }
    let(:predicate)   { empty[:id].gte(1)                          }
    let(:restriction) { Algebra::Restriction.new(empty, predicate) }

    it { should equal(empty) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == restriction
    end
  end

  describe 'with an empty relation when optimized' do
    let(:other)       { Algebra::Restriction.new(relation, Logic::Proposition::False.instance) }
    let(:predicate)   { other[:id].gte(1)                                                      }
    let(:restriction) { Algebra::Restriction.new(other, predicate)                             }

    it { should eql(Relation::Empty.new(relation.header)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == restriction
    end
  end

  describe 'with a restriction' do
    let(:other_predicate) { relation[:id].lt(2)                                 }
    let(:other)           { Algebra::Restriction.new(relation, other_predicate) }
    let(:predicate)       { relation[:id].gte(1)                                }
    let(:restriction)     { Algebra::Restriction.new(other, predicate)          }

    it { should_not equal(restriction) }

    it { should be_instance_of(Algebra::Restriction) }

    it 'sets the predicate' do
      subject.predicate.should eql(other_predicate & predicate)
    end

    its(:relation) { should equal(relation) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == restriction
    end
  end

  describe 'with a set operation' do
    let(:left)        { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
    let(:right)       { Relation.new([ [ :id, Integer ] ], [ [ 2 ] ]) }
    let(:union)       { left.union(right)                             }
    let(:predicate)   { union[:id].gte(1)                             }
    let(:restriction) { Algebra::Restriction.new(union, predicate)    }

    it 'pushes the restriction to each relation' do
      should eql(left.restrict { |r| r[:id].gte(1) }.union(right.restrict { |r| r[:id].gte(1) }) )
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == restriction
    end
  end

  describe 'with a set operation, containing a restriction with duplicate predicates' do
    let(:left)        { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])                                   }
    let(:right)       { Relation.new([ [ :id, Integer ] ], [ [ 2 ] ])                                   }
    let(:union)       { left.restrict { |r| r[:id].gte(1) }.union(right.restrict { |r| r[:id].gte(1) }) }
    let(:restriction) { union.restrict { |r| r[:id].gte(1) }                                            }

    it 'pushes the restriction to each relation, and then removes duplicate predicates' do
      should eql(left.restrict { |r| r[:id].gte(1) }.union(right.restrict { |r| r[:id].gte(1) }) )
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == restriction
    end
  end

  describe 'with a reverse operation' do
    let(:limit)       { relation.order { |r| r.header }.limit(2) }
    let(:reverse)     { limit.reverse                            }
    let(:predicate)   { reverse[:id].gte(1)                      }
    let(:restriction) { reverse.restrict(predicate)              }

    it 'pushes the restriction under the reverse' do
      should eql(limit.restrict(predicate).reverse)
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == restriction
    end
  end

  describe 'with a reverse operation, containing a restriction with duplicate predicates' do
    let(:limit)       { relation.order { |r| r.header }.limit(2)     }
    let(:reverse)     { limit.restrict { |r| r[:id].gte(1) }.reverse }
    let(:predicate)   { reverse[:id].gte(1)                          }
    let(:restriction) { reverse.restrict(predicate)                  }

    it 'pushes the restriction under the reverse, and then removes duplicate predicates' do
      should eql(limit.restrict(predicate).reverse)
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == restriction
    end
  end

  describe 'with an order operation' do
    let(:order)       { relation.order { |r| r.header } }
    let(:predicate)   { order[:id].gte(1)               }
    let(:restriction) { order.restrict(predicate)       }

    it 'pushes the restriction under the order' do
      should eql(relation.restrict(predicate).order { |r| r.header })
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == restriction
    end
  end

  describe 'with an order operation, containing a restriction with duplicate predicates' do
    let(:order)       { relation.restrict { |r| r[:id].gte(1) }.order { |r| r.header } }
    let(:predicate)   { order[:id].gte(1)                                              }
    let(:restriction) { order.restrict(predicate)                                      }

    it 'pushes the restriction under the order, and then removes duplicate predicates' do
      should eql(relation.restrict(predicate).order { |r| r.header })
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == restriction
    end
  end
end
