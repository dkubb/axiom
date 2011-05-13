# encoding: utf-8

require 'spec_helper'

describe Function::Numeric::Subtraction, '#inspect' do
  subject { object.inspect }

  let(:object) { described_class.new(1, 1) }

  it { should == '(1 - 1)' }
end
