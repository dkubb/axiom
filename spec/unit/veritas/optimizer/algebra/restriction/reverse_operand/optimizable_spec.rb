require 'spec_helper'

describe Optimizer::Algebra::Restriction::ReverseOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:base)      { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each).order }
  let(:predicate) { base[:id].eq(1)                                          }
  let(:relation)  { operand.restrict(predicate)                              }
  let(:object)    { described_class.new(relation)                            }

  before do
    object.operation.should be_kind_of(Algebra::Restriction)
  end

  context 'when the operand is a reverse operation' do
    let(:operand) { base.take(2).reverse }

    it { should be(true) }
  end

  context 'when the operand is not a reverse operation' do
    let(:operand) { base }

    it { should be(false) }
  end
end
