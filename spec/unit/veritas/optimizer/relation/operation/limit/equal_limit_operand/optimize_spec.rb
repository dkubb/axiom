require 'spec_helper'

describe Optimizer::Relation::Operation::Limit::EqualLimitOperand, '#optimize' do
  subject { object.optimize }

  let(:order)    { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each).order }
  let(:limit)    { order.take(1)                                            }
  let(:relation) { limit.take(1)                                            }
  let(:object)   { described_class.new(relation)                            }

  before do
    object.operation.should be_kind_of(Relation::Operation::Limit)
    object.operand.should be_kind_of(Relation::Operation::Limit)
  end

  it { should equal(limit) }
end
