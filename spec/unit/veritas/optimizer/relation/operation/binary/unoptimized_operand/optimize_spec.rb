require 'spec_helper'

describe 'Veritas::Optimizer::Relation::Operation::Binary::UnoptimizedOperand#optimize' do
  subject { object.optimize }

  let(:klass)    { Optimizer::Relation::Operation::Binary::UnoptimizedOperand }
  let(:left)     { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each)         }
  let(:right)    { Relation.new([ [ :id, Integer ] ], [ [ 2 ] ].each)         }
  let(:relation) { left.union(right)                                          }
  let(:object)   { klass.new(relation)                                        }

  it { should be_kind_of(Algebra::Union) }

  it { should_not equal(relation) }

  its(:left) { should equal(left) }

  its(:right) { should equal(right) }
end
