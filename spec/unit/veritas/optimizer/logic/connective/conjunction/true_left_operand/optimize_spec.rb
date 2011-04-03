require 'spec_helper'

describe Optimizer::Logic::Connective::Conjunction::TrueLeftOperand, '#optimize' do
  subject { object.optimize }

  let(:attribute)  { Attribute::Integer.new(:id)                     }
  let(:left)       { Logic::Proposition::True.instance               }
  let(:right)      { attribute.eq(1)                                 }
  let(:connective) { Logic::Connective::Conjunction.new(left, right) }
  let(:object)     { described_class.new(connective)                 }

  before do
    object.should be_optimizable
  end

  it { should equal(right) }
end
