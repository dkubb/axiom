require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Connective::Negation#operand' do
  let(:attribute) { Attribute::Integer.new(:id)              }
  let(:operand)   { attribute.eq(1)                          }
  let(:negation)  { Logic::Connective::Negation.new(operand) }

  subject { negation.operand }

  it { should equal(operand) }
end
