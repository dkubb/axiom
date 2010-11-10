require 'spec_helper'

describe 'Veritas::Optimizer::Relation::Operation::Limit::InequalLimitOperand#optimizable?' do
  subject { object.optimizable? }

  let(:klass)    { Optimizer::Relation::Operation::Limit::InequalLimitOperand }
  let(:base)     { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each).order   }
  let(:relation) { operand.take(1)                                            }
  let(:object)   { klass.new(relation)                                        }

  before do
    object.operation.should be_kind_of(Relation::Operation::Limit)
  end

  context 'when the operand is limited and not equal to the operation' do
    let(:operand) { base.take(2) }

    it { should be(true) }
  end

  context 'when the operand is limited and equal to the operation' do
    let(:operand) { base.take(1) }

    it { should be(false) }
  end

  context 'when the operand is not limited' do
    let(:operand) { base }

    it { should be(false) }
  end
end
