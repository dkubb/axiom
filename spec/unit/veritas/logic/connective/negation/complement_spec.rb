require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Connective::Negation#complement' do
  subject { negation.complement }

  let(:attribute) { Attribute::Integer.new(:id)              }
  let(:operand)   { attribute.eq(1)                          }
  let(:negation)  { Logic::Connective::Negation.new(operand) }

  it 'returns the operand' do
    should equal(operand)
  end

  it 'is not reversible' do
    subject.complement.should_not eql(negation)
  end
end
