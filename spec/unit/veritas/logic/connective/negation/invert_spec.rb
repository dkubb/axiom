require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Connective::Negation#invert' do
  let(:attribute) { Attribute::Integer.new(:id)              }
  let(:operand)   { attribute.eq(1)                          }
  let(:negation)  { Logic::Connective::Negation.new(operand) }

  subject { negation.invert }

  it 'returns the operand' do
    should equal(operand)
  end

  it 'does not invert back to original' do
    subject.invert.should_not eql(negation)
  end
end
