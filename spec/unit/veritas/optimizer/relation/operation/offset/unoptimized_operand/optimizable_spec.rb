require 'spec_helper'

describe Optimizer::Relation::Operation::Offset::UnoptimizedOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:header)   { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:base)     { Relation.new(header, [ [ 1 ] ].each).order }
  let(:relation) { operand.drop(1)                            }
  let(:object)   { described_class.new(relation)              }

  before do
    object.operation.should be_kind_of(Relation::Operation::Offset)
  end

  context 'when the operand is optimizable' do
    let(:operand) { base.rename({}) }

    it { should be(true) }
  end

  context 'when the operand is not optimizable' do
    let(:operand) { base }

    it { should be(false) }
  end
end
