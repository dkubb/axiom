# encoding: utf-8

require 'spec_helper'

describe Function::Connective::Negation, '#inspect' do
  subject { object.inspect }

  let(:attribute) { Attribute::Integer.new(:id)  }
  let(:operand)   { attribute.eq(1)              }
  let(:object)    { described_class.new(operand) }

  it { should == "NOT(#{operand.inspect})" }
end
