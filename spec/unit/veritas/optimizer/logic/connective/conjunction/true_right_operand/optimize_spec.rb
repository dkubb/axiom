require 'spec_helper'

describe Optimizer::Logic::Connective::Conjunction::TrueRightOperand, '#optimize' do
  subject { object.optimize }

  let(:attribute)  { Attribute::Integer.new(:id)       }
  let(:left)       { attribute.eq(1)                   }
  let(:right)      { Logic::Proposition::True.instance }
  let(:connective) { left.and(right)                   }
  let(:object)     { described_class.new(connective)   }

  before do
    object.operation.should be_kind_of(Logic::Connective::Conjunction)
  end

  it { should equal(left) }
end
