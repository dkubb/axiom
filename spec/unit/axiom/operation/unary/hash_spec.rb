# encoding: utf-8

require 'spec_helper'

describe Operation::Unary, '#hash' do
  subject { object.hash }

  let(:described_class) { Class.new { include Operation::Unary } }
  let(:operand)         { double('Operand').freeze               }
  let(:object)          { described_class.new(operand)           }

  it_should_behave_like 'a hash method'

  it { should == described_class.hash ^ operand.hash }
end
