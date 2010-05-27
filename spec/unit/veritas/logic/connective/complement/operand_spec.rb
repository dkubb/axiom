require 'spec_helper'

describe 'Veritas::Logic::Connective::Complement#operand' do
  subject { complement.operand }

  let(:attribute)  { Attribute::Integer.new(:id)                }
  let(:operand)    { attribute.eq(1)                            }
  let(:complement) { Logic::Connective::Complement.new(operand) }

  it { should equal(operand) }
end
