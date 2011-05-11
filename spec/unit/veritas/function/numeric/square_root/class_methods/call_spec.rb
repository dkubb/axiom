require 'spec_helper'

describe Function::Numeric::SquareRoot, '.call' do
  subject { object.call(value) }

  let(:object) { described_class }
  let(:value)  { 4               }

  it { should eql(2.0) }
end
