require 'spec_helper'

describe 'Veritas::Optimizer::Logic::Connective::Disjunction::FalseLeftOperand#optimizable?' do
  subject { object.optimizable? }

  let(:klass)      { Optimizer::Logic::Connective::Disjunction::FalseLeftOperand }
  let(:attribute)  { Attribute::Integer.new(:id)                                 }
  let(:connective) { Logic::Connective::Disjunction.new(left, right)             }
  let(:object)     { klass.new(connective)                                       }

  before do
    object.operation.should be_kind_of(Logic::Connective::Disjunction)
  end

  context 'when right is true' do
    let(:left)  { Veritas::Logic::Proposition::False.instance }
    let(:right) { attribute.eq(1)                             }

    it { should be(true) }
  end

  context 'when right is not true' do
    let(:left)  { attribute.eq(1) }
    let(:right) { attribute.eq(1) }

    it { should be(false) }
  end
end
