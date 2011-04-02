require 'spec_helper'

describe Optimizer::Algebra::Restriction::OrderOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:klass)     { Optimizer::Algebra::Restriction::OrderOperand      }
  let(:base)      { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each) }
  let(:predicate) { base[:id].eq(1)                                    }
  let(:relation)  { operand.restrict(predicate)                        }
  let(:object)    { klass.new(relation)                                }

  before do
    object.operation.should be_kind_of(Algebra::Restriction)
  end

  context 'when the operand is an order operation' do
    let(:operand) { base.order }

    it { should be(true) }
  end

  context 'when the operand is not an order operation' do
    let(:operand) { base }

    it { should be(false) }
  end
end
