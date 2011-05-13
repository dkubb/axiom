# encoding: utf-8

require 'spec_helper'

describe Function::Numeric::Random, '#inspect' do
  subject { object.inspect }

  let(:object) { described_class.new(1) }

  it { should == 'RAND(1)' }
end
