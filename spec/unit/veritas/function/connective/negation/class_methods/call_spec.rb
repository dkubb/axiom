require 'spec_helper'

describe Function::Connective::Negation, '.call' do
  subject { object.call(operand) }

  let(:object) { described_class }

  context 'when operand is true' do
    let(:operand) { true }

    it { should be(false) }
  end

  context 'when operand is false' do
    let(:operand) { false }

    it { should be(true) }
  end
end
