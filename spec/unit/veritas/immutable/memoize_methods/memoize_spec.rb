require 'spec_helper'
require File.expand_path('../../fixtures/classes', __FILE__)

describe 'Veritas::Immutable::MemoizeMethods#memoize' do
  subject { immutable.memoize(method, value) }

  let(:klass)     { Class.new(ImmutableSpecs::Object) }
  let(:immutable) { klass.new                         }
  let(:method)    { :test                             }
  let(:value)     { String.new.freeze                 }

  before do
    klass.memoize(method)
  end

  it 'sets the memoized value for the method to the value' do
    subject
    immutable.send(method).should equal(value)
  end
end
