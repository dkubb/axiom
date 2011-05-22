# encoding: utf-8

require 'spec_helper'

describe Function::String::Length, '.call' do
  subject { object.call(value) }

  let(:object) { described_class }
  let(:value)  { 'a string'      }

  it { should eql(8) }
end
