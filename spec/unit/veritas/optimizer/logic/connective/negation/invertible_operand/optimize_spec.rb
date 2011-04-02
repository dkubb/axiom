require 'spec_helper'

describe Optimizer::Logic::Connective::Negation::InvertibleOperand, '#optimize' do
  subject { object.optimize }

  let(:attribute) { Attribute::Integer.new(:id)              }
  let(:operand)   { attribute.eq(1)                          }
  let(:negation)  { Logic::Connective::Negation.new(operand) }
  let(:object)    { described_class.new(negation)            }

  before do
    object.operation.should be_kind_of(Logic::Connective::Negation)
  end

  it { should be_kind_of(Logic::Predicate::Inequality) }

  its(:left) { should equal(attribute) }

  its(:right) { should == 1 }
end
