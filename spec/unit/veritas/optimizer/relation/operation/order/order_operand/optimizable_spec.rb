require 'spec_helper'

describe 'Veritas::Optimizer::Relation::Operation::Order::OrderOperand#optimizable?' do
  subject { object.optimizable? }

  let(:klass)    { Optimizer::Relation::Operation::Order::OrderOperand }
  let(:base)     { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each)  }
  let(:relation) { operand.order                                       }
  let(:object)   { klass.new(relation)                                 }

  before do
    object.operation.should be_kind_of(Relation::Operation::Order)
  end

  context 'when the operand is ordered' do
    let(:operand) { base.order }

    it { should be(true) }
  end

  context 'when the operand is not ordered' do
    let(:operand) { base }

    it { should be(false) }
  end
end
