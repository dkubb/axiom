require 'spec_helper'

describe Optimizer::Logic::Predicate::Util, '.max' do
  subject { object.max(operand) }

  let(:object) { Optimizer::Logic::Predicate::Util }

  context 'with an attribute' do
    let(:operand) { Attribute::Integer.new(:id, :size => 1..10) }

    it { should == 10 }
  end

  context 'with a constant' do
    let(:operand) { 1 }

    it { should == 1 }
  end
end
