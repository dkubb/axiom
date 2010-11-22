require 'spec_helper'

describe 'Veritas::Optimizer::Logic::Predicate::Comparable::NeverComparable#optimizable?' do
  subject { object.optimizable? }

  let(:klass)     { Class.new(Optimizer::Logic::Predicate)      }
  let(:attribute) { Attribute::Integer.new(:id)                 }
  let(:predicate) { Logic::Predicate::Equality.new(left, right) }
  let(:object)    { klass.new(predicate)                        }

  before do
    klass.class_eval { include Optimizer::Logic::Predicate::Comparable::NeverComparable }

    predicate.should be_kind_of(Logic::Predicate::Comparable)
  end

  context 'when left is a constant and is valid' do
    let(:left)  { 1         }
    let(:right) { attribute }

    it { should be(false) }
  end

  context 'when left is a constand and is not valid' do
    let(:left)  { 'a'       }
    let(:right) { attribute }

    it { should be(true) }
  end

  context 'when right is a constant and is valid' do
    let(:left)  { attribute }
    let(:right) { 1         }

    it { should be(false) }
  end

  context 'when right is a constant and is not valid' do
    let(:left)  { attribute }
    let(:right) { 'a'       }

    it { should be(true) }
  end

  context 'when left and right are comparable' do
    let(:left)  { attribute }
    let(:right) { attribute }

    it { should be(false) }
  end

  context 'when left and right are not comparable' do
    let(:left)  { attribute                    }
    let(:right) { Attribute::String.new(:name) }

    it { should be(true) }
  end
end
