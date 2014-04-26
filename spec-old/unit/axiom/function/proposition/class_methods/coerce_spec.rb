# encoding: utf-8

require 'spec_helper'

describe Function::Proposition, '.coerce' do
  subject { object.coerce(argument) }

  let(:object) { described_class }

  context 'with a tautology' do
    let(:argument) { Function::Proposition::Tautology.instance }

    it { should be(Function::Proposition::Tautology.instance) }
  end

  context 'with a contradiction' do
    let(:argument) { Function::Proposition::Contradiction.instance }

    it { should be(Function::Proposition::Contradiction.instance) }
  end

  context 'with true argument' do
    let(:argument) { true }

    it { should be(Function::Proposition::Tautology.instance) }
  end

  context 'with false argument' do
    let(:argument) { false }

    it { should be(Function::Proposition::Contradiction.instance) }
  end

  context 'with a truthy argument' do
    let(:argument) { 1 }

    specify { expect { subject }.to raise_error(ArgumentError, 'Invalid object 1') }
  end

  context 'with a falsey argument' do
    let(:argument) { nil }

    specify { expect { subject }.to raise_error(ArgumentError, 'Invalid object nil') }
  end
end
