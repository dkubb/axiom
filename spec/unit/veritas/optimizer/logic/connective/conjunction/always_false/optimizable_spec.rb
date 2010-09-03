require 'spec_helper'

describe 'Veritas::Optimizer::Logic::Connective::Conjunction::AlwaysFalse#optimizable?' do
  subject { object.optimizable? }

  let(:klass)      { Optimizer::Logic::Connective::Conjunction::AlwaysFalse }
  let(:attribute)  { Attribute::Integer.new(:id)                            }
  let(:connective) { Logic::Connective::Conjunction.new(left, right)        }
  let(:object)     { klass.new(connective)                                  }

  before do
    object.operation.should be_kind_of(Logic::Connective::Conjunction)
  end

  context 'when left is false' do
    let(:left)  { Logic::Proposition::False.instance }
    let(:right) { attribute.eq(1)                    }

    it { should be(true) }
  end

  context 'when right is false' do
    let(:left)  { attribute.eq(1)                    }
    let(:right) { Logic::Proposition::False.instance }

    it { should be(true) }
  end

  context 'when left and right are equality predicates with the same attribute and constant values' do
    let(:left)  { attribute.eq(1) }
    let(:right) { attribute.eq(2) }

    it { should be(true) }
  end

  context 'when left and right are complements' do
    let(:left)  { attribute.eq(1) }
    let(:right) { attribute.ne(1) }

    it { should be(true) }
  end
end
