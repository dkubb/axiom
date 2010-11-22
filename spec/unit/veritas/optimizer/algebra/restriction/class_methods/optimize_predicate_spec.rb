require 'spec_helper'

describe 'Veritas::Optimizer::Algebra::Restriction.optimize_predicate' do
  subject { object.optimize_predicate(predicate) }

  let(:attribute) { Attribute::Integer.new(:id)     }
  let(:predicate) { attribute.eq(1)                 }
  let(:object)    { Optimizer::Algebra::Restriction }

  context 'when the predicate is optimizable' do
    let(:predicate) { Logic::Connective::Negation.new(attribute.eq(1)) }

    it { should be_kind_of(Logic::Predicate::Inequality) }

    its(:left) { should equal(attribute) }

    its(:right) { should == 1 }
  end

  context 'when the predicate is optimizable, but already optimized' do
    let(:predicate) { attribute.eq(1) }

    it { should equal(predicate) }
  end

  context 'when the predicate is not optimizable' do
    let(:predicate) { lambda { |tuple| tuple[:id] == 1 } }

    it { should equal(predicate) }
  end
end
