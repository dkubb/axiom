require 'spec_helper'

describe Optimizer::Relation::Operation::Order::UnoptimizedOperand, '#optimize' do
  subject { object.optimize }

  let(:klass)    { Optimizer::Relation::Operation::Order::UnoptimizedOperand }
  let(:base)     { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each)        }
  let(:relation) { base.order                                                }
  let(:object)   { klass.new(relation)                                       }

  before do
    object.operation.should be_kind_of(Relation::Operation::Order)
  end

  it { should be_kind_of(Relation::Operation::Order) }

  it { should_not equal(relation) }

  its(:operand) { should equal(base) }

  its(:directions) { should equal(relation.directions) }
end
