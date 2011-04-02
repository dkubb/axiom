require 'spec_helper'

describe Operation::Binary, '#left' do
  subject { object.left }

  let(:described_class) { Class.new { include Operation::Binary } }
  let(:right)           { 'Right'                                 }
  let(:object)          { described_class.new(left, right)        }

  context 'when left operand is frozen' do
    let(:left) { 'Left'.freeze }

    it { should equal(left) }
  end

  context 'when left operand is not frozen' do
    let(:left) { 'Left' }

    it { should_not equal(left) }

    it { should be_frozen }

    it { should == left }
  end
end
