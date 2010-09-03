require 'spec_helper'

describe 'Veritas::Optimizer::Logic::Predicate::Util.min' do
  subject { object.min(operand) }

  let(:object) { Optimizer::Logic::Predicate::Util }

  context 'with an attribute' do
    let(:operand) { Attribute::Integer.new(:id, :size => 1..10) }

    it { should == 1 }
  end

  context 'with a constant' do
    let(:operand) { 1 }

    it { should == 1 }
  end
end
