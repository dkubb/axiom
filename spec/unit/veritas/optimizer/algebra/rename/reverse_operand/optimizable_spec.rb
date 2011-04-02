require 'spec_helper'

describe Optimizer::Algebra::Rename::ReverseOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:base)     { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each) }
  let(:relation) { operand.rename(:id => :other_id)                   }
  let(:object)   { described_class.new(relation)                      }

  before do
    object.operation.should be_kind_of(Algebra::Rename)
  end

  context 'when the operand is an reverse operation' do
    let(:operand) { base.order.take(2).reverse }

    it { should be(true) }
  end

  context 'when the operand is not an reverse operation' do
    let(:operand) { base }

    it { should be(false) }
  end
end
