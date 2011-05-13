# encoding: utf-8

require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Immutable, '#memoized' do
  subject { object.memoized(method) }

  let(:described_class) { Class.new(ImmutableSpecs::Object) }
  let(:method)          { :test                             }
  let(:value)           { String.new.freeze                 }
  let(:object)          { described_class.new               }

  before do
    described_class.memoize(method)
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
