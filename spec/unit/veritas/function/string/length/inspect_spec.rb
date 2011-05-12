require 'spec_helper'

describe Function::String::Length, '#inspect' do
  subject { object.inspect }

  let(:object) { described_class.new('a string') }

  it { should == 'LENGTH("a string")' }
end
