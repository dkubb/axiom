require 'spec_helper'
require File.expand_path('../../fixtures/classes', __FILE__)

describe 'Veritas::Immutable::MemoizeMethods#memoize' do
  subject { immutable.memoize(method, value) }

  let(:klass)     { Class.new(ImmutableSpecs::Object) }
  let(:immutable) { klass.new                         }
  let(:method)    { :test                             }
  let(:value)     { String.new                        }

  before do
    klass.memoize(method)
  end

  context 'with a frozen value' do
    before do
      value.freeze
    end

    it { should equal(immutable) }

    it 'sets the memoized value for the method to the value' do
      subject
      immutable.send(method).should equal(value)
    end
  end

  context 'with an unfrozen value' do
    it { should equal(immutable) }

    it 'sets the memoized value for the method to a different value' do
      subject
      immutable.send(method).should_not equal(value)
    end

    it 'sets the memoized value to an equivalent value' do
      subject
      immutable.send(method).should eql(value)
    end
  end
end
