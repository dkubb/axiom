require 'spec_helper'

describe Optimizer::Logic::Predicate::LessThanOrEqualTo::AlwaysFalse, '#optimizable?' do
  subject { object.optimizable? }

  let(:attribute) { Attribute::Integer.new(:id)    }
  let(:predicate) { left.lte(right)                }
  let(:object)    { described_class.new(predicate) }

  before do
    predicate.should be_kind_of(Logic::Predicate::LessThanOrEqualTo)
  end

  context 'when left and right are equal' do
    let(:left)  { attribute }
    let(:right) { attribute }

    it { should be(false) }
  end

  context 'when left and right are different types' do
    let(:left)  { attribute                    }
    let(:right) { Attribute::String.new(:name) }

    it { should be(true) }
  end

  context 'when left is always greater than right' do
    let(:left)  { Attribute::Integer.new(:id, :size => 10..20) }
    let(:right) { Attribute::Integer.new(:id, :size => 1..9)   }

    it { should be(true) }
  end

  context 'when left is equivalent to the right' do
    let(:left)  { Attribute::Integer.new(:id) }
    let(:right) { Attribute::Integer.new(:id) }

    it { should be(false) }
  end
end
