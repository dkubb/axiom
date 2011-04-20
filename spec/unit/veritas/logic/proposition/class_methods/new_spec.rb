require 'spec_helper'

describe Logic::Proposition, '.new' do
  let(:object) { described_class }

  context 'with true argument' do
    subject { object.new(argument) }

    let(:argument) { true }

    it { should equal(Logic::Proposition::True.instance) }
  end

  context 'with false argument' do
    subject { object.new(argument) }

    let(:argument) { false }

    it { should equal(Logic::Proposition::False.instance) }
  end

  context 'with no arguments' do
    subject { object.new }

    specify { pending { expect { subject }.to raise_error(NotImplementedError, "#{object} is an abstract class") } }
  end
end
