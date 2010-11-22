require 'spec_helper'

describe 'Veritas::Algebra::Rename#optimize' do
  subject { object.optimize }

  let(:klass)    { Algebra::Rename                                             }
  let(:body)     { [ [ 1, 'Dan Kubb' ] ].each                                  }
  let(:relation) { Relation.new([ [ :id, Integer ], [ :name, String ] ], body) }
  let(:operand)  { relation                                                    }
  let(:aliases)  { { :id => :other_id }                                        }
  let(:object)   { klass.new(operand, aliases)                                 }

  context 'containing a relation' do
    it { should equal(object) }

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing an empty relation' do
    let(:operand) { Relation::Empty.new(relation.header) }

    it { should eql(Relation::Empty.new(object.header)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing an optimizable relation' do
    let(:operand) { relation.project(relation.header) }

    it { should_not equal(object) }

    it { should be_kind_of(klass) }

    it 'sets aliases the same as the original object' do
      subject.aliases.should == object.aliases
    end

    its(:operand) { should equal(relation) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a object operation' do
    let(:operand) { klass.new(relation, :id => :other_id) }
    let(:aliases) { { :name => :other_name }              }

    it { should_not equal(object) }

    it { should be_kind_of(klass) }

    it 'sets aliases as a union of both aliases' do
      subject.aliases.should == klass::Aliases.coerce(
        relation.header,
        :id   => :other_id,
        :name => :other_name
      )
    end

    its(:operand) { should equal(relation) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a object operation with overlapping aliases' do
    let(:operand) { klass.new(relation, :id => :other_id) }
    let(:aliases) { { :other_id => :another_id }          }

    it { should_not equal(object) }

    it { should be_kind_of(klass) }

    it 'sets aliases as a union of both aliases' do
      subject.aliases.should == klass::Aliases.coerce(
        relation.header,
        :id => :another_id
      )
    end

    its(:operand) { should equal(relation) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing an inverse object operation' do
    let(:operand) { klass.new(relation, :id => :other_id) }
    let(:aliases) { { :other_id => :id }                  }

    it { should equal(relation) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a projection' do
    let(:operand) { relation.project([ :id ]) }

    it { should be_kind_of(Algebra::Projection) }

    its(:operand) { should eql(klass.new(relation, aliases)) }

    its(:header) { should == [ [ :other_id, Integer ] ] }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a projection, containing a object that cancels out' do
    let(:operand) { relation.rename(:id => :other_id).project([ :other_id ]) }
    let(:aliases) { { :other_id => :id }                                     }

    it 'pushes the object before the projection, and then cancel it out' do
      should eql(relation.project([ :id ]))
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a restriction' do
    let(:operand) { relation.restrict { |r| r[:id].eq(1) } }

    it { should be_kind_of(Algebra::Restriction) }

    its(:operand) { should eql(klass.new(relation, aliases)) }

    its(:header) { should == [ [ :other_id, Integer ], [ :name, String ] ] }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a restriction, containing a object that cancels out' do
    let(:operand) { relation.rename(:id => :other_id).restrict { |r| r[:other_id].eq(1) } }
    let(:aliases) { { :other_id => :id }                                                  }

    it 'pushes the object before the restriction, and then cancel it out' do
      should eql(relation.restrict { |r| r[:id].eq(1) })
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a set operation' do
    let(:left)    { Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 1, 'Dan Kubb' ] ].each) }
    let(:right)   { Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 2, 'Dan Kubb' ] ].each) }
    let(:operand) { left.union(right)                                                                 }

    it 'pushes the object to each relation' do
      should eql(left.rename(aliases).union(right.rename(aliases)))
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a set operation, containing a object that cancels out' do
    let(:left)    { Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 1, 'Dan Kubb' ] ].each) }
    let(:right)   { Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 2, 'Dan Kubb' ] ].each) }
    let(:operand) { left.rename(:id => :other_id).union(right.rename(:id => :other_id))               }
    let(:aliases) { { :other_id => :id }                                                              }

    it 'pushes the object to each relation, then cancel it out' do
      should eql(left.union(right))
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a reverse operation' do
    let(:limit)   { relation.order.take(2) }
    let(:operand) { limit.reverse          }

    it 'pushes the object under the order, limit and reverse' do
      should eql(relation.rename(aliases).order.take(2).reverse)
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a reverse operation, containing a object that cancels out' do
    let(:limit)   { relation.order.take(2)                 }
    let(:operand) { limit.rename(:id => :other_id).reverse }
    let(:aliases) { { :other_id => :id }                   }

    it 'pushes the object under the order, limit and reverse, and then cancel it out' do
      should eql(relation.order.take(2).reverse)
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing an order operation' do
    let(:operand) { relation.order }

    it 'pushes the object under the order' do
      should eql(relation.rename(aliases).order)
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing an order operation, containing a object that cancels out' do
    let(:operand) { relation.rename(:id => :other_id).order }
    let(:aliases) { { :other_id => :id }                    }

    it 'pushes the object under the order, and then cancel it out' do
      should eql(relation.order)
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a limit operation' do
    let(:order)   { relation.order }
    let(:operand) { order.take(2)  }

    it 'pushes the object under the limit and order' do
      should eql(relation.rename(aliases).order.take(2))
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a limit operation, containing a object that cancels out' do
    let(:order)   { relation.order                         }
    let(:operand) { order.rename(:id => :other_id).take(2) }
    let(:aliases) { { :other_id => :id }                   }

    it 'pushes the object under the limit and order, and then cancel it out' do
      should eql(relation.order.take(2))
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing an offset operation' do
    let(:order)   { relation.order }
    let(:operand) { order.drop(1)  }

    it 'pushes the object under the offset and order' do
      should eql(relation.rename(aliases).order.drop(1))
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing an offset operation, containing a object that cancels out' do
    let(:order)   { relation.order                         }
    let(:operand) { order.rename(:id => :other_id).drop(1) }
    let(:aliases) { { :other_id => :id }                   }

    it 'pushes the object under the offset and order, and then cancel it out' do
      should eql(relation.order.drop(1))
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a materialized relation' do
    let(:operand) { Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 1, 'Dan Kubb' ] ]) }

    it { should eql(Relation::Materialized.new([ [ :other_id, Integer ], [ :name, String ] ], [ [ 1, 'Dan Kubb' ] ])) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it_should_behave_like 'an optimize method'
  end
end
