require 'spec_helper'

describe 'Veritas::Logic::Connective::Complement.eval' do
  subject { Logic::Connective::Complement.eval(operand) }

  context 'when operand is true' do
    let(:operand) { true }

    it { should be(false) }
  end

  context 'when operand is false' do
    let(:operand) { false }

    it { should be(true) }
  end
end
