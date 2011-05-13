# encoding: utf-8

require 'spec_helper'

describe Function::Numeric::SquareRoot, '#inspect' do
  subject { object.inspect }

  let(:object) { described_class.new(4) }

  it { should == 'SQRT(4)' }
end
