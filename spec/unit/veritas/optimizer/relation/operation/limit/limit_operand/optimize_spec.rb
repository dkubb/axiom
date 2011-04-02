require 'spec_helper'

describe Optimizer::Relation::Operation::Limit::LimitOperand, '#optimize' do
  subject { object.optimize }

  let(:klass)  { Optimizer::Relation::Operation::Limit::LimitOperand      }
  let(:order)  { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each).order }
  let(:limit)  { order.take(2)                                            }
  let(:object) { klass.new(relation)                                      }

  before do
    object.operation.should be_kind_of(Relation::Operation::Limit)
    object.operand.should be_kind_of(Relation::Operation::Limit)
  end

  context 'when the operand has a larger limit than the operation' do
    let(:relation) { limit.take(1) }

    it { should be_kind_of(Relation::Operation::Limit) }

    its(:operand) { should equal(order) }

    its(:limit) { should == 1 }
  end

  context 'when the operand has a smaller limit than the operation' do
    let(:relation) { limit.take(3) }

    it { should be_kind_of(Relation::Operation::Limit) }

    its(:operand) { should equal(order) }

    its(:limit) { should == 2 }
  end
end
