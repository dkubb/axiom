require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Immutable, '#dup' do
  subject { object.dup }

  let(:klass)  { ImmutableSpecs::Object }
  let(:object) { klass.new              }

  it { should equal(object) }
end
