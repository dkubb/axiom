require 'spec_helper'

describe Optimizer::Logic::Connective::Disjunction::AlwaysTrue, '#optimizable?' do
  subject { object.optimizable? }

  let(:klass)      { Optimizer::Logic::Connective::Disjunction::AlwaysTrue }
  let(:attribute)  { Attribute::Integer.new(:id)                           }
  let(:connective) { Logic::Connective::Disjunction.new(left, right)       }
  let(:object)     { klass.new(connective)                                 }

  before do
    object.operation.should be_kind_of(Logic::Connective::Disjunction)
  end

  context 'when left is true' do
    let(:left)  { Logic::Proposition::True.instance }
    let(:right) { attribute.eq(1)                   }

    it { should be(true) }
  end

  context 'when right is true' do
    let(:left)  { attribute.eq(1)                   }
    let(:right) { Logic::Proposition::True.instance }

    it { should be(true) }
  end

  context 'when left and right are inequality predicates with the same attribute and constant values' do
    let(:left)  { attribute.ne(1) }
    let(:right) { attribute.ne(2) }

    it { should be(true) }
  end

  context 'when left and right are inverses' do
    let(:left)  { attribute.eq(1) }
    let(:right) { attribute.ne(1) }

    it { should be(true) }
  end
end
