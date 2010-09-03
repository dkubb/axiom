require 'spec_helper'

describe 'Veritas::Optimizer::Logic::Connective::Binary::EqualOperands#optimizable?' do
  subject { object.optimizable? }

  let(:klass)      { Optimizer::Logic::Connective::Binary::EqualOperands }
  let(:attribute)  { Attribute::Integer.new(:id)                         }
  let(:connective) { left.and(right)                                     }
  let(:object)     { klass.new(connective)                               }

  before do
    object.operation.should be_kind_of(Logic::Connective::Binary)
  end

  context 'when left and right are equivalent' do
    let(:left)  { attribute.eq(1) }
    let(:right) { attribute.eq(1) }

    it { should be(true) }
  end

  context 'when left and right are not equivalent' do
    let(:left)  { attribute.eq(1) }
    let(:right) { attribute.ne(1) }

    it { should be(false) }
  end
end
