require 'spec_helper'

describe Optimizer::Logic::Connective::Binary::RedundantRightOperand, '#optimize' do
  subject { object.optimize }

  let(:attribute)  { Attribute::Integer.new(:id)     }
  let(:left)       { attribute.include([ 1 ])        }
  let(:right)      { attribute.exclude([ 2 ])        }
  let(:connective) { left.and(left.and(right))       }
  let(:object)     { described_class.new(connective) }

  before do
    object.operation.should be_kind_of(Logic::Connective::Binary)
  end

  it { should be_kind_of(Logic::Connective::Conjunction) }

  its(:left) { should eql(attribute.eq(1)) }

  its(:right) { should eql(attribute.ne(2)) }
end
