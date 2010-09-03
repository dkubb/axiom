require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Immutable#memoize' do
  subject { object.memoize(name, value) }

  let(:klass)  { ImmutableSpecs::Object }
  let(:name)   { mock('Name')           }
  let(:value)  { mock('Value')          }
  let(:object) { klass.new              }

  it { should equal(object) }
end
