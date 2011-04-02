require 'spec_helper'

describe Optimizer::Relation::Operation::Order::OneLimitOperand, '#optimize' do
  subject { object.optimize }

  let(:base)     { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each) }
  let(:limit)    { base.order.take(1)                                 }
  let(:relation) { limit.order                                        }
  let(:object)   { described_class.new(relation)                      }

  before do
    object.operation.should be_kind_of(Relation::Operation::Order)
    object.operand.should be_kind_of(Relation::Operation::Limit)
  end

  it { should equal(limit) }
end
