require 'spec_helper'

describe 'Veritas::Logic::Connective::Negation#inverse' do
  subject { negation.inverse }

  let(:attribute) { Attribute::Integer.new(:id)              }
  let(:operand)   { attribute.eq(1)                          }
  let(:negation)  { Logic::Connective::Negation.new(operand) }

  it 'returns the operand' do
    should equal(operand)
  end

  it 'is not invertible' do
    subject.inverse.should_not eql(negation)
  end

  it_should_behave_like 'an idempotent method'
end
