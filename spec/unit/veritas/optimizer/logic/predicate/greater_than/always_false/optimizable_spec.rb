require 'spec_helper'

describe 'Veritas::Optimizer::Logic::Predicate::GreaterThan::AlwaysFalse#optimizable?' do
  subject { object.optimizable? }

  let(:klass)     { Optimizer::Logic::Predicate::GreaterThan::AlwaysFalse }
  let(:attribute) { Attribute::Integer.new(:id)                           }
  let(:predicate) { left.gt(right)                                        }
  let(:object)    { klass.new(predicate)                                  }

  before do
    predicate.should be_kind_of(Veritas::Logic::Predicate::GreaterThan)
  end

  context 'when left and right are equal' do
    let(:left)  { attribute }
    let(:right) { attribute }

    it { should be(true) }
  end

  context 'when left and right are different types' do
    let(:left)  { attribute                    }
    let(:right) { Attribute::String.new(:name) }

    it { should be(true) }
  end

  context 'when left is always less than right' do
    let(:left)  { Attribute::Integer.new(:id, :size => 1..9)   }
    let(:right) { Attribute::Integer.new(:id, :size => 10..20) }

    it { should be(true) }
  end

  context 'when left is equivalent to the right' do
    let(:left)  { Attribute::Integer.new(:id) }
    let(:right) { Attribute::Integer.new(:id) }

    it { should be(false) }
  end
end