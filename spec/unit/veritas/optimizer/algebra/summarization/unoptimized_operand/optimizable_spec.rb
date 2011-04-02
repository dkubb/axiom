require 'spec_helper'

describe Optimizer::Algebra::Summarization::UnoptimizedOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:header)      { Relation::Header.new([ [ :id, Integer ] ])             }
  let(:base)        { Relation.new(header, [ [ 1 ] ].each)                   }
  let(:summarizers) { [ :text, lambda { |acc, tuple| 1 } ]                   }
  let(:relation)    { operand.summarize(operand) { |r| r.add(*summarizers) } }
  let(:object)      { described_class.new(relation)                          }

  before do
    object.operation.should be_kind_of(Algebra::Summarization)
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
