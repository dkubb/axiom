require 'spec_helper'

describe 'Veritas::Logic::Connective::Complement#inverse' do
  subject { complement.inverse }

  let(:attribute)  { Attribute::Integer.new(:id)                }
  let(:operand)    { attribute.eq(1)                            }
  let(:complement) { Logic::Connective::Complement.new(operand) }

  it 'returns the operand' do
    should equal(operand)
  end

  it 'is not invertible' do
    subject.inverse.should_not eql(complement)
  end

  it_should_behave_like 'an idempotent method'
end
