require 'spec_helper'

describe 'Veritas::Algebra::Rename#optimize' do
  subject { rename.optimize }

  let(:relation) { Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 1, 'Dan Kubb' ] ]) }
  let(:aliases)  { { :id => :other_id }                                                         }

  context 'containing a relation' do
    let(:rename) { Algebra::Rename.new(relation, aliases) }

    it { should equal(rename) }

    it_should_behave_like 'an optimize method'
  end

  context 'containing an empty relation' do
    let(:empty)  { Relation::Empty.new(relation.header) }
    let(:rename) { Algebra::Rename.new(empty, aliases)  }

    it { should eql(Relation::Empty.new(rename.header)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == rename
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing an optimizable relation' do
    let(:projection) { relation.project(relation.header)        }
    let(:rename)     { Algebra::Rename.new(projection, aliases) }

    it { should_not equal(rename) }

    it { should be_instance_of(Algebra::Rename) }

    it 'sets aliases the same as the original rename' do
      subject.aliases.should == rename.aliases
    end

    its(:relation) { should equal(relation) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == rename
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a rename operation' do
    let(:rename) do
      rename = Algebra::Rename.new(relation, :id => :other_id)
      Algebra::Rename.new(rename, :name => :other_name)
    end

    it { should_not equal(rename) }

    it { should be_instance_of(Algebra::Rename) }

    it 'sets aliases as a union of both aliases' do
      subject.aliases.should == aliases.merge(:name => :other_name)
    end

    its(:relation) { should equal(relation) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == rename
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a rename operation with overlapping aliases' do
    let(:rename) do
      rename = Algebra::Rename.new(relation, :id => :other_id)
      Algebra::Rename.new(rename, :other_id => :another_id)
    end

    it { should_not equal(rename) }

    it { should be_instance_of(Algebra::Rename) }

    it 'sets aliases as a union of both aliases' do
      subject.aliases.should == { :id => :another_id }
    end

    its(:relation) { should equal(relation) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == rename
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing an inverse rename operation' do
    let(:rename) do
      rename = Algebra::Rename.new(relation, :id => :other_id)
      Algebra::Rename.new(rename, :other_id => :id)
    end

    it { should equal(relation) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == rename
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a projection' do
    let(:projection) { relation.project([ :id ])                }
    let(:rename)     { Algebra::Rename.new(projection, aliases) }

    it { should be_instance_of(Algebra::Projection) }

    its(:relation) { should eql(Algebra::Rename.new(relation, aliases)) }

    its(:header) { should == [ [ :other_id, Integer ] ] }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == rename
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a projection, containing a rename that cancels out' do
    let(:projection) { relation.rename(:id => :other_id).project([ :other_id ]) }
    let(:rename)     { Algebra::Rename.new(projection, :other_id => :id)        }

    it 'pushes the rename before the projection, and then cancel it out' do
      should eql(relation.project([ :id ]))
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == rename
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a restriction' do
    let(:restriction) { relation.restrict { |r| r[:id].eq(1) }    }
    let(:rename)      { Algebra::Rename.new(restriction, aliases) }

    it { should be_instance_of(Algebra::Restriction) }

    its(:relation) { should eql(Algebra::Rename.new(relation, aliases)) }

    its(:header) { should == [ [ :other_id, Integer ], [ :name, String ] ] }

    its(:predicate) { should eql(rename[:other_id].eq(1)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == rename
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a restriction, containing a rename that cancels out' do
    let(:projection) { relation.rename(:id => :other_id).restrict { |r| r[:other_id].eq(1) } }
    let(:rename)     { Algebra::Rename.new(projection, :other_id => :id)                     }

    it 'pushes the rename before the restriction, and then cancel it out' do
      should eql(relation.restrict { |r| r[:id].eq(1) })
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == rename
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a set operation' do
    let(:left)   { Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 1, 'Dan Kubb' ] ]) }
    let(:right)  { Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 2, 'Dan Kubb' ] ]) }
    let(:union)  { left.union(right)                                                            }
    let(:rename) { union.rename(aliases)                                                        }

    it 'pushes the rename to each relation' do
      should eql(left.rename(aliases).union(right.rename(aliases)))
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == rename
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a set operation, containing a rename that cancels out' do
    let(:left)   { Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 1, 'Dan Kubb' ] ]) }
    let(:right)  { Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 2, 'Dan Kubb' ] ]) }
    let(:union)  { left.rename(:id => :other_id).union(right.rename(:id => :other_id))          }
    let(:rename) { union.rename(:other_id => :id)                                               }

    it 'pushes the rename to each relation, then cancel it out' do
      should eql(left.union(right))
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == rename
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a reverse operation' do
    let(:limit)   { relation.order { |r| r.header }.limit(2) }
    let(:reverse) { limit.reverse                            }
    let(:rename)  { reverse.rename(aliases)                  }

    it 'pushes the rename under the order, limit and reverse' do
      should eql(relation.rename(aliases).order { |r| r.header }.limit(2).reverse)
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == rename
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a reverse operation, containing a rename that cancels out' do
    let(:limit)   { relation.order { |r| r.header }.limit(2) }
    let(:reverse) { limit.rename(:id => :other_id).reverse   }
    let(:rename)  { reverse.rename(:other_id => :id)         }

    it 'pushes the rename under the order, limit and reverse, and then cancel it out' do
      should eql(relation.order { |r| r.header }.limit(2).reverse)
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == rename
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing an order operation' do
    let(:order)  { relation.order { |r| r.header } }
    let(:rename) { order.rename(aliases)           }

    it 'pushes the rename under the order' do
      should eql(relation.rename(aliases).order { |r| r.header })
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == rename
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing an order operation, containing a rename that cancels out' do
    let(:order)  { relation.rename(:id => :other_id).order { |r| r.header } }
    let(:rename) { order.rename(:other_id => :id)                           }

    it 'pushes the rename under the order, and then cancel it out' do
      should eql(relation.order { |r| r.header })
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == rename
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a limit operation' do
    let(:order)  { relation.order { |r| r.header } }
    let(:limit)  { order.limit(2)                  }
    let(:rename) { limit.rename(aliases)           }

    it 'pushes the rename under the limit and order' do
      should eql(relation.rename(aliases).order { |r| r.header }.limit(2))
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == rename
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a limit operation, containing a rename that cancels out' do
    let(:order)  { relation.order { |r| r.header }         }
    let(:limit)  { order.rename(:id => :other_id).limit(2) }
    let(:rename) { limit.rename(:other_id => :id)          }

    it 'pushes the rename under the limit and order, and then cancel it out' do
      should eql(relation.order { |r| r.header }.limit(2))
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == rename
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing an offset operation' do
    let(:order)  { relation.order { |r| r.header } }
    let(:offset) { order.offset(1)                 }
    let(:rename) { offset.rename(aliases)          }

    it 'pushes the rename under the offset and order' do
      should eql(relation.rename(aliases).order { |r| r.header }.offset(1))
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == rename
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing an offset operation, containing a rename that cancels out' do
    let(:order)  { relation.order { |r| r.header }          }
    let(:offset) { order.rename(:id => :other_id).offset(1) }
    let(:rename) { offset.rename(:other_id => :id)          }

    it 'pushes the rename under the offset and order, and then cancel it out' do
      should eql(relation.order { |r| r.header }.offset(1))
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == rename
    end

    it_should_behave_like 'an optimize method'
  end
end
