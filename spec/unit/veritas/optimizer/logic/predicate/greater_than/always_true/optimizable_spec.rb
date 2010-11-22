require 'spec_helper'

describe 'Veritas::Optimizer::Logic::Predicate::GreaterThan::AlwaysTrue#optimizable?' do
  subject { object.optimizable? }

  let(:klass)     { Optimizer::Logic::Predicate::GreaterThan::AlwaysTrue }
  let(:predicate) { left.gt(right)                                       }
  let(:object)    { klass.new(predicate)                                 }

  before do
    predicate.should be_kind_of(Logic::Predicate::GreaterThan)
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
