require 'spec_helper'

describe 'Veritas::Optimizer::Logic::Connective::Disjunction::OptimizableToInclusion#optimize' do
  subject { object.optimize }

  let(:klass)      { Optimizer::Logic::Connective::Disjunction::OptimizableToInclusion }
  let(:attribute)  { Attribute::Integer.new(:id)                                       }
  let(:connective) { left.or(right)                                                    }
  let(:object)     { klass.new(connective)                                             }

  before do
    object.operation.should be_kind_of(Logic::Connective::Disjunction)
  end

  context 'when the right operands are optimizable' do
    let(:left)  { attribute.eq(2) }
    let(:right) { attribute.eq(1) }

    it { should be_kind_of(Logic::Predicate::Inclusion) }

    its(:left) { should equal(attribute) }

    # enumerable order is normalized
    its(:right) { should == [ 1, 2 ] }
  end

  context 'when the right operands are not optimizable' do
    let(:left)  { attribute.eq(1) }
    let(:right) { attribute.eq(2) }

    it { should be_kind_of(Logic::Predicate::Inclusion) }

    its(:left) { should equal(attribute) }

    its(:right) { should == [ 1, 2 ] }
  end
end
