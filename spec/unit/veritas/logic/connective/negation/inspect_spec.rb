require 'spec_helper'

describe Logic::Connective::Negation, '#inspect' do
  subject { object.inspect }

  let(:klass)     { Logic::Connective::Negation }
  let(:attribute) { Attribute::Integer.new(:id) }
  let(:operand)   { attribute.eq(1)             }
  let(:object)    { klass.new(operand)          }

  it { should == "not(#{operand.inspect})" }
end
