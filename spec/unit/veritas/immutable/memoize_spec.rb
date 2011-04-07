require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Immutable, '#memoize' do
  subject { object.memoize(method, value) }

  let(:described_class) { Class.new(ImmutableSpecs::Object) }
  let(:object)          { described_class.new               }
  let(:method)          { :test                             }
  let(:value)           { String.new.freeze                 }

  before do
    described_class.memoize(method)
  end

  it 'sets the memoized value for the method to the value' do
    subject
    object.send(method).should equal(value)
  end
end
