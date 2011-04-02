require 'spec_helper'

describe Optimizer::Relation::Operation::Binary::UnoptimizedOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:optimized)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:unoptimized) { optimized.project(optimized.header)           }
  let(:relation)    { left.union(right)                             }
  let(:object)      { described_class.new(relation)                 }

  context 'when the left and right operands are optimized' do
    let(:left)  { optimized }
    let(:right) { optimized }

    it { should be(false) }
  end

  context 'when the left operand is not optimized and the right operand is optimized' do
    let(:left)  { unoptimized }
    let(:right) { optimized   }

    it { should be(true) }
  end

  context 'when the left operand is optimized and the right operand is not optimized' do
    let(:left)  { optimized   }
    let(:right) { unoptimized }

    it { should be(true) }
  end

  context 'when the left and right operands are not optimized' do
    let(:left)  { unoptimized }
    let(:right) { unoptimized }

    it { should be(true) }
  end
end
