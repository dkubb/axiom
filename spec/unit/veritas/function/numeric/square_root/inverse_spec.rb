require 'spec_helper'

describe Function::Numeric::SquareRoot, '#inverse' do
  subject { object.inverse }

  let(:object) { described_class.new(value) }
  let(:value)  { 4                          }

  it 'is invertible' do
    should eql(Function::Numeric::Exponentiation.new(value, 2))
  end
end
