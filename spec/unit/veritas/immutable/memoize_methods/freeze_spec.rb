require 'spec_helper'
require File.expand_path('../../fixtures/classes', __FILE__)

describe 'Veritas::Immutable::MemoizeMethods#freeze' do
  subject { immutable.freeze }

  let(:klass) { ImmutableSpecs::Object }

  before do
    klass.memoize(:test)
  end

  context 'with an unfrozen object' do
    let(:immutable) { klass.allocate }

    it { should equal(immutable) }

    it 'freezes the object' do
      method(:subject).should change(immutable, :frozen?).from(false).to(true)
    end

    it 'sets a memoization instance variable' do
      immutable.should_not be_instance_variable_defined(:@__memory)
      subject
      immutable.instance_variable_get(:@__memory).should be_kind_of(Immutable::Memory)
    end
  end

  context 'with a frozen object' do
    let(:immutable) { klass.new }

    it { should equal(immutable) }

    it 'does not change the frozen state of the object' do
      method(:subject).should_not change(immutable, :frozen?)
    end

    it 'does not change the memoization instance variable' do
      method(:subject).should_not change { immutable.instance_variable_get(:@__memory) }
    end

    it 'sets an instance variable for memoization' do
      subject.instance_variable_get(:@__memory).should be_kind_of(Immutable::Memory)
    end
  end
end
