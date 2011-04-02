require 'spec_helper'
require File.expand_path('../../fixtures/classes', __FILE__)

describe Immutable::MemoizeMethods, '#memoized' do
  subject { object.memoized(method) }

  let(:klass)  { Class.new(ImmutableSpecs::Object) }
  let(:method) { :test                             }
  let(:value)  { String.new.freeze                 }
  let(:object) { klass.new                         }

  before do
    klass.memoize(method)
  end

  context 'when a method is memoized' do
    before do
      object.memoize(method, value)
    end

    it { should equal(value) }
  end

  context 'when a method is not memoized' do
    it { should be_nil }
  end
end
