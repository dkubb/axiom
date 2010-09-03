require 'spec_helper'

describe 'Veritas::Optimizer::Relation::Operation::Binary::UnoptimizedOperand#optimize' do
  subject { object.optimize }

  let(:klass)    { Optimizer::Relation::Operation::Binary::UnoptimizedOperand }
  let(:left)     { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])              }
  let(:right)    { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])              }
  let(:relation) { left.union(right)                                          }
  let(:object)   { klass.new(relation)                                        }

  it { should_not equal(relation) }

  it { should eql(relation) }
end
