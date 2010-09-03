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

    it 'reorders the operands by optimizing the inclusion' do
      should eql(attribute.include([ 1, 2 ]))
    end
  end

  context 'when the right operands are not optimizable' do
    let(:left)  { attribute.eq(1) }
    let(:right) { attribute.eq(2) }

    it { should eql(attribute.include([ 1, 2 ])) }
  end
end
