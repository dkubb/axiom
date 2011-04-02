require 'spec_helper'

describe Optimizer::Logic::Predicate, '#right' do
  subject { object.right }

  let(:klass)     { Optimizer::Logic::Predicate                  }
  let(:left)      { 'Left'                                       }
  let(:predicate) { Class.new(Logic::Predicate).new(left, right) }
  let(:object)    { klass.new(predicate)                         }

  context 'when right operand is frozen' do
    let(:right) { 'Right'.freeze }

    it { should equal(right) }
  end

  context 'when right operand is not frozen' do
    let(:right) { 'Right' }

    it { should_not equal(right) }

    it { should be_frozen }

    it { should == right }
  end
end
