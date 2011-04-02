require 'spec_helper'

describe Optimizer::Relation::Operation::Order::OneLimitOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:base)     { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each) }
  let(:relation) { operand.order                                      }
  let(:object)   { described_class.new(relation)                      }

  before do
    object.operation.should be_kind_of(Relation::Operation::Order)
  end

  context 'when the operand is limited to 1' do
    let(:operand) { base.order.take(1) }

    it { should be(true) }
  end

  context 'when the operand is not limited to 1' do
    let(:operand) { base.order.take(2) }

    it { should be(false) }
  end

  context 'when the operand is not limited' do
    let(:operand) { base }

    it { should be(false) }
  end
end
