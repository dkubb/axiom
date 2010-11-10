require 'spec_helper'

describe 'Veritas::Algebra::Restriction#optimize' do
  subject { object.optimize }

  let(:klass)    { Algebra::Restriction                     }
  let(:body)     { [ [ 1 ] ].each                           }
  let(:relation) { Relation.new([ [ :id, Integer ] ], body) }
  let(:operand)  { relation                                 }
  let(:object)   { klass.new(operand, predicate)            }

  context 'with a true proposition' do
    let(:predicate) { Logic::Proposition::True.instance }

    it { should equal(relation) }

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'with a false proposition' do
    let(:predicate) { Logic::Proposition::False.instance }

    it { should eql(Relation::Empty.new(relation.header)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'with a predicate' do
    let(:predicate) { relation[:id].eq(1) }

    it { should equal(object) }

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'with an optimizable predicate' do
    let(:predicate) { relation[:id].eq(1).and(Logic::Proposition::True.instance) }

    it { should_not equal(object) }

    it { should be_instance_of(klass) }

    its(:predicate) { should eql(relation[:id].eq(1)) }

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

  context 'with an optimizable operand' do
    let(:operand)    { relation.project(relation.header) }
    let(:predicate)  { relation[:id].eq(1)               }

    it { should_not equal(object) }

    it { should be_instance_of(klass) }

    its(:predicate) { should equal(predicate) }

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

  context 'with an empty relation' do
    let(:operand)   { Relation::Empty.new([ [ :id, Integer ] ]) }
    let(:predicate) { operand[:id].gte(1)                       }

    it { should equal(operand) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'with an empty relation when optimized' do
    let(:operand)   { klass.new(relation, Logic::Proposition::False.instance) }
    let(:predicate) { operand[:id].gte(1)                                     }

    it { should eql(Relation::Empty.new(relation.header)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'with a restriction' do
    let(:other_predicate) { relation[:id].lt(2)            }
    let(:operand)   { klass.new(relation, other_predicate) }
    let(:predicate) { operand[:id].gte(1)                  }

    it { should_not equal(object) }

    it { should be_instance_of(klass) }

    its(:predicate) { should eql(other_predicate & predicate) }

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

  context 'with a set operation' do
    let(:left)      { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each) }
    let(:right)     { Relation.new([ [ :id, Integer ] ], [ [ 2 ] ].each) }
    let(:operand)   { left.union(right)                                  }
    let(:predicate) { operand[:id].gte(1)                                }

    it 'pushes the object to each relation' do
      should eql(left.restrict { |r| r[:id].gte(1) }.union(right.restrict { |r| r[:id].gte(1) }))
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

  context 'with a set operation, containing a object with duplicate predicates' do
    let(:left)      { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each)                              }
    let(:right)     { Relation.new([ [ :id, Integer ] ], [ [ 2 ] ].each)                              }
    let(:operand)   { left.restrict { |r| r[:id].gte(1) }.union(right.restrict { |r| r[:id].gte(1) }) }
    let(:predicate) { operand[:id].gte(1)                                                             }

    it 'pushes the object to each relation, and then removes duplicate predicates' do
      should eql(left.restrict { |r| r[:id].gte(1) }.union(right.restrict { |r| r[:id].gte(1) }))
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

  context 'with a reverse operation' do
    let(:limit)     { relation.order.take(2) }
    let(:operand)   { limit.reverse          }
    let(:predicate) { operand[:id].gte(1)    }

    it 'pushes the object under the reverse' do
      should eql(limit.restrict(predicate).reverse)
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

  context 'with a reverse operation, containing a object with duplicate predicates' do
    let(:limit)     { relation.order.take(2)                       }
    let(:operand)   { limit.restrict { |r| r[:id].gte(1) }.reverse }
    let(:predicate) { operand[:id].gte(1)                          }

    it 'pushes the object under the reverse, and then removes duplicate predicates' do
      should eql(limit.restrict(predicate).reverse)
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

  context 'with an order operation' do
    let(:operand)   { relation.order      }
    let(:predicate) { operand[:id].gte(1) }

    it 'pushes the object under the order' do
      should eql(relation.restrict(predicate).order)
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

  context 'with an order operation, containing a object with duplicate predicates' do
    let(:operand)   { relation.restrict { |r| r[:id].gte(1) }.order }
    let(:predicate) { operand[:id].gte(1)                           }

    it 'pushes the object under the order, and then removes duplicate predicates' do
      should eql(relation.restrict(predicate).order)
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
    let(:operand)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ]) }
    let(:predicate) { operand[:id].eq(1)                                   }

    it { should eql(Relation::Materialized.new([ [ :id, Integer ] ], [ [ 1 ] ])) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it_should_behave_like 'an optimize method'
  end
end
