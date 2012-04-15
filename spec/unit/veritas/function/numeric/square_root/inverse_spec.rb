# encoding: utf-8

require 'spec_helper'

describe Function::Numeric::SquareRoot, '#inverse' do
  subject { object.inverse }

  let(:object) { described_class.new(value) }
  let(:value)  { 4                          }

  it_should_behave_like 'an invertible method'

  it { should be_instance_of(Function::Numeric::Exponentiation) }

  it 'returns an exponentiation of the expected value' do
    should eql(Function::Numeric::Exponentiation.new(value, 2))
  end
end
