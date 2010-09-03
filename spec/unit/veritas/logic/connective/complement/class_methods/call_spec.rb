require 'spec_helper'

describe 'Veritas::Logic::Connective::Complement.call' do
  subject { Logic::Connective::Complement.call(operand) }

  context 'when operand is true' do
    let(:operand) { true }

    it { should be(false) }
  end

  context 'when operand is false' do
    let(:operand) { false }

    it { should be(true) }
  end
end
