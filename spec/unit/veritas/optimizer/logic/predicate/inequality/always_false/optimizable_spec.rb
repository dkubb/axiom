require 'spec_helper'

describe 'Veritas::Optimizer::Logic::Predicate::Inequality::AlwaysFalse#optimizable?' do
  subject { object.optimizable? }

  let(:klass)     { Optimizer::Logic::Predicate::Inequality::AlwaysFalse }
  let(:attribute) { Attribute::Integer.new(:id)                          }
  let(:predicate) { left.ne(right)                                       }
  let(:object)    { klass.new(predicate)                                 }

  before do
    predicate.should be_kind_of(Veritas::Logic::Predicate::Inequality)
  end

  context 'when left and right are equal' do
    let(:left)  { attribute }
    let(:right) { attribute }

    it { should be(true) }
  end

  context 'when left and right are not equal' do
    let(:left)  { attribute }
    let(:right) { 1         }

    it { should be(false) }
  end
end
