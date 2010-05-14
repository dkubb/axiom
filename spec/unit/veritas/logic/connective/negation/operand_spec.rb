require 'spec_helper'

describe 'Veritas::Logic::Connective::Negation#operand' do
  subject { negation.operand }

  let(:attribute) { Attribute::Integer.new(:id)              }
  let(:operand)   { attribute.eq(1)                          }
  let(:negation)  { Logic::Connective::Negation.new(operand) }

  it { should equal(operand) }
end
