# encoding: utf-8

require 'spec_helper'

describe Function::Numeric::Absolute, '#inspect' do
  subject { object.inspect }

  let(:object) { described_class.new(-1) }

  it { should == 'ABS(-1)' }
end
