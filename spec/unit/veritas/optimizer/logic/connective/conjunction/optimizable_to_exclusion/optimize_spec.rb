require 'spec_helper'

describe 'Veritas::Optimizer::Logic::Connective::Conjunction::OptimizableToExclusion#optimize' do
  subject { object.optimize }

  let(:klass)      { Optimizer::Logic::Connective::Conjunction::OptimizableToExclusion }
  let(:attribute)  { Attribute::Integer.new(:id)                                       }
  let(:connective) { left.and(right)                                                   }
  let(:object)     { klass.new(connective)                                             }

  before do
    object.operation.should be_kind_of(Logic::Connective::Conjunction)
  end

  context 'when the right operands are optimizable' do
    let(:left)  { attribute.ne(2) }
    let(:right) { attribute.ne(1) }

    it { should be_kind_of(Logic::Predicate::Exclusion) }

    its(:left) { should equal(attribute) }

    # enumerable order is normalized
    its(:right) { should == [ 1, 2 ] }
  end

  context 'when the right operands are not optimizable' do
    let(:left)  { attribute.ne(1) }
    let(:right) { attribute.ne(2) }

    it { should be_kind_of(Logic::Predicate::Exclusion) }

    its(:left) { should equal(attribute) }

    its(:right) { should == [ 1, 2 ] }
  end
end
