require 'spec_helper'

describe 'Veritas::Optimizer::Logic::Predicate::Util.attribute?' do
  subject { object.attribute?(operand) }

  let(:object) { Optimizer::Logic::Predicate::Util }

  context 'with an attribute' do
    let(:operand) { Attribute::Integer.new(:id) }

    it { should be(true) }
  end

  context 'with a constant' do
    let(:operand) { 1 }

    it { should be(false) }
  end
end
