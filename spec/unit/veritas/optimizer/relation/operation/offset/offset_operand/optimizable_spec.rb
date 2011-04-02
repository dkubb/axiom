require 'spec_helper'

describe Optimizer::Relation::Operation::Offset::OffsetOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:base)     { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each).order }
  let(:relation) { operand.drop(1)                                          }
  let(:object)   { described_class.new(relation)                            }

  before do
    object.operation.should be_kind_of(Relation::Operation::Offset)
  end

  context 'when the operand is an offset' do
    let(:operand) { base.drop(1) }

    it { should be(true) }
  end

  context 'when the operand is not an offset' do
    let(:operand) { base }

    it { should be(false) }
  end
end
