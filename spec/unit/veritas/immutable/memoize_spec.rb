require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Immutable, '#memoize' do
  subject { object.memoize(name, value) }

  let(:described_class) { ImmutableSpecs::Object }
  let(:name)            { mock('Name')           }
  let(:value)           { mock('Value')          }
  let(:object)          { described_class.new    }

  it { should equal(object) }
end
