require 'spec_helper'
require File.expand_path('../../fixtures/classes', __FILE__)

describe Immutable::MemoizeMethods, '#freeze' do
  subject { object.freeze }

  let(:klass) { Class.new(ImmutableSpecs::Object) }

  before do
    klass.memoize(:test)
  end

  context 'with an unfrozen object' do
    let(:object) { klass.allocate }

    it { should equal(object) }

    it 'freezes the object' do
      expect { subject }.to change(object, :frozen?).
        from(false).
        to(true)
    end

    it 'sets a memoization instance variable' do
      object.should_not be_instance_variable_defined(:@__memory)
      subject
      object.instance_variable_get(:@__memory).should be_kind_of(Immutable::Memory)
    end
  end

  context 'with a frozen object' do
    let(:object) { klass.new }

    it { should equal(object) }

    it 'does not change the frozen state of the object' do
      expect { subject }.to_not change(object, :frozen?)
    end

    it 'does not change the memoization instance variable' do
      expect { subject }.to_not change { object.instance_variable_get(:@__memory) }
    end

    it 'sets an instance variable for memoization' do
      subject.instance_variable_get(:@__memory).should be_kind_of(Immutable::Memory)
    end
  end
end
