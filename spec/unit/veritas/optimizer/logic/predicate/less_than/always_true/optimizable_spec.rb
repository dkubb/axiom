require 'spec_helper'

describe 'Veritas::Optimizer::Logic::Predicate::LessThan::AlwaysTrue#optimizable?' do
  subject { object.optimizable? }

  let(:klass)     { Optimizer::Logic::Predicate::LessThan::AlwaysTrue }
  let(:predicate) { left.lt(right)                                    }
  let(:object)    { klass.new(predicate)                              }

  before do
    predicate.should be_kind_of(Veritas::Logic::Predicate::LessThan)
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
