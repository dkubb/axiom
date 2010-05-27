require 'spec_helper'

describe 'Veritas::Logic::Connective::Complement#complement' do
  subject { complement.complement }

  let(:attribute)  { Attribute::Integer.new(:id)                }
  let(:operand)    { attribute.eq(1)                            }
  let(:complement) { Logic::Connective::Complement.new(operand) }

  it 'returns the operand' do
    should equal(operand)
  end

  it 'is not reversible' do
    subject.complement.should_not eql(complement)
  end
end
