require 'spec_helper'

describe 'Veritas::Logic::Connective::Complement#inspect' do
  subject { complement.inspect }

  let(:attribute)  { Attribute::Integer.new(:id)                }
  let(:operand)    { attribute.eq(1)                            }
  let(:complement) { Logic::Connective::Complement.new(operand) }

  it { should == "NOT(#{operand.inspect})" }
end
