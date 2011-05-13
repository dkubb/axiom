# encoding: utf-8

require 'spec_helper'

describe Function::Proposition, '.new' do
  let(:object) { described_class }

  context 'with true argument' do
    subject { object.new(argument) }

    let(:argument) { true }

    it { should equal(Function::Proposition::Tautology.instance) }
  end

  context 'with false argument' do
    subject { object.new(argument) }

    let(:argument) { false }

    it { should equal(Function::Proposition::Contradiction.instance) }
  end

  context 'with no arguments' do
    subject { object.new }

    specify { pending { expect { subject }.to raise_error(NotImplementedError, "#{object} is an abstract class") } }
  end
end
