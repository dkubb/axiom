require 'spec_helper'

describe 'Veritas::Logic::Connective::Negation#inverse' do
  subject { object.inverse }

  let(:klass)     { Logic::Connective::Negation }
  let(:attribute) { Attribute::Integer.new(:id) }
  let(:operand)   { attribute.eq(1)             }
  let(:object)    { klass.new(operand)          }

  it_should_behave_like 'an idempotent method'

  it 'returns the operand' do
    should equal(operand)
  end

  it 'is not invertible' do
    subject.inverse.should_not eql(object)
  end
end
