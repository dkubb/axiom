require 'spec_helper'

describe Logic::Connective::Negation, '.call' do
  subject { object.call(operand) }

  let(:object) { Logic::Connective::Negation }

  context 'when operand is true' do
    let(:operand) { true }

    it { should be(false) }
  end

  context 'when operand is false' do
    let(:operand) { false }

    it { should be(true) }
  end
end
