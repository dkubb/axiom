require 'spec_helper'
require File.expand_path('../../../fixtures/classes', __FILE__)

describe 'Veritas::Immutable::Memory.memoized_value' do
  subject { klass.memoized_value(value) }

  let(:klass) { Immutable::Memory }

  context 'with a numeric value' do
    let(:value) { 1 }

    it { should equal(value) }
  end

  context 'with a true value' do
    let(:value) { true }

    it { should equal(value) }
  end

  context 'with a false value' do
    let(:value) { false }

    it { should equal(value) }
  end

  context 'with a nil value' do
    let(:value) { nil }

    it { should equal(value) }
  end

  context 'with a frozen value' do
    let(:value) { String.new.freeze }

    it { should equal(value) }
  end

  context 'with an unfrozen value' do
    let(:value) { String.new }

    it { should_not equal(value) }

    it { should eql(value) }
  end
end
