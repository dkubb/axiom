require 'spec_helper'

describe Optimizer::Logic::Connective::Conjunction::OptimizableToExclusion, '#optimizable?' do
  subject { object.optimizable? }

  let(:klass)      { Optimizer::Logic::Connective::Conjunction::OptimizableToExclusion }
  let(:attribute)  { Attribute::Integer.new(:id)                                       }
  let(:connective) { left.and(right)                                                   }
  let(:object)     { klass.new(connective)                                             }

  before do
    object.operation.should be_kind_of(Logic::Connective::Conjunction)
  end

  context 'when the operands are optimizable' do
    let(:left)  { attribute.ne(2) }
    let(:right) { attribute.ne(1) }

    it { should be(true) }
  end

  context 'when the operands are not optimizable' do
    let(:left)  { attribute.ne(1) }
    let(:right) { attribute.eq(2) }

    it { should be(false) }
  end
end
