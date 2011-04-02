require 'spec_helper'

describe Operation::Unary, '#operand' do
  subject { object.operand }

  let(:described_class) { Class.new { include Operation::Unary } }
  let(:object)          { described_class.new(operand)           }

  context 'when operand is frozen' do
    let(:operand) { 'Operand'.freeze }

    it { should equal(operand) }
  end

  context 'when operand is not frozen' do
    let(:operand) { 'Operand' }

    it { should_not equal(operand) }

    it { should be_frozen }

    it { should == operand }
  end
end
