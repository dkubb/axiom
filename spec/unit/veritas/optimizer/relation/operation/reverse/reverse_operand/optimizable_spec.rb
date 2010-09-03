require 'spec_helper'

describe 'Veritas::Optimizer::Relation::Operation::Reverse::ReverseOperand#optimizable?' do
  subject { object.optimizable? }

  let(:klass)    { Optimizer::Relation::Operation::Reverse::ReverseOperand  }
  let(:base)     { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each).order }
  let(:relation) { operand.reverse                                          }
  let(:object)   { klass.new(relation)                                      }

  before do
    object.operation.should be_kind_of(Relation::Operation::Reverse)
  end

  context 'when the operand is reversed' do
    let(:operand) { base.offset(1).reverse }

    it { should be(true) }
  end

  context 'when the operand is not reversed' do
    let(:operand) { base }

    it { should be(false) }
  end
end
