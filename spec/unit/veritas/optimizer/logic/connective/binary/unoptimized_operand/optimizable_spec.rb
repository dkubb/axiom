require 'spec_helper'

describe Optimizer::Logic::Connective::Binary::UnoptimizedOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:attribute)  { Attribute::Integer.new(:id)     }
  let(:connective) { left.and(right)                 }
  let(:object)     { described_class.new(connective) }

  before do
    object.operation.should be_kind_of(Logic::Connective::Binary)
  end

  context 'when left is optimizable' do
    let(:left)  { attribute.include([ 1 ]) }
    let(:right) { attribute.ne(2)          }

    it { should be(true) }
  end

  context 'when right is optimizable' do
    let(:left)  { attribute.eq(1)          }
    let(:right) { attribute.exclude([ 2 ]) }

    it { should be(true) }
  end

  context 'when left and right are not optimizable' do
    let(:left)  { attribute.eq(1) }
    let(:right) { attribute.ne(2) }

    it { should be(false) }
  end
end
