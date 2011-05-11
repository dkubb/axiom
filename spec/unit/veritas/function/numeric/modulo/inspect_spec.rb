require 'spec_helper'

describe Function::Numeric::Modulo, '#inspect' do
  subject { object.inspect }

  let(:object) { described_class.new(1, 1) }

  it { should == '(1 % 1)' }
end
