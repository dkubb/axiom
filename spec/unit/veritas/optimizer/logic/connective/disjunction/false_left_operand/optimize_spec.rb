require 'spec_helper'

describe Optimizer::Logic::Connective::Disjunction::FalseLeftOperand, '#optimize' do
  subject { object.optimize }

  let(:attribute)  { Attribute::Integer.new(:id)                     }
  let(:left)       { Logic::Proposition::False.instance              }
  let(:right)      { attribute.eq(1)                                 }
  let(:connective) { Logic::Connective::Disjunction.new(left, right) }
  let(:object)     { described_class.new(connective)                 }

  before do
    object.operation.should be_kind_of(Logic::Connective::Disjunction)
  end

  it { should equal(right) }
end
