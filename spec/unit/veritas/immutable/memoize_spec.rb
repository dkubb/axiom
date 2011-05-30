# encoding: utf-8

require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Immutable, '#memoize' do
  subject { object.memoize(method, value) }

  let(:described_class) { Class.new(ImmutableSpecs::Object) }
  let(:object)          { described_class.new               }
  let(:method)          { :test                             }

  before do
    described_class.memoize(method)
  end

  context 'when the value is frozen' do
    let(:value) { String.new.freeze }

    it 'sets the memoized value for the method to the value' do
      subject
      object.send(method).should equal(value)
    end

    it 'creates a method that returns a frozen value' do
      subject
      object.send(method).should be_frozen
    end
  end

  context 'when the value is not frozen' do
    let(:value) { String.new }

    it 'sets the memoized value for the method to the value' do
      subject
      object.send(method).should eql(value)
    end

    it 'creates a method that returns a frozen value' do
      subject
      object.send(method).should be_frozen
    end
  end
end
