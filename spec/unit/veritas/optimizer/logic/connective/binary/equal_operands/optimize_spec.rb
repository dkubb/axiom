require 'spec_helper'

describe Optimizer::Logic::Connective::Binary::EqualOperands, '#optimize' do
  subject { object.optimize }

  let(:attribute)  { Attribute::Integer.new(:id)     }
  let(:left)       { attribute.eq(1)                 }
  let(:right)      { attribute.eq(1)                 }
  let(:connective) { left.and(right)                 }
  let(:object)     { described_class.new(connective) }

  before do
    object.operation.should be_kind_of(Logic::Connective::Binary)
  end

  it { should equal(left) }
end
