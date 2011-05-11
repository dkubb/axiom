require 'spec_helper'

describe Function::Numeric::Subtraction, '.call' do
  subject { object.call(left, right) }

  let(:object) { described_class }
  let(:left)   { 2               }
  let(:right)  { 2               }

  it { should == 0 }
end
