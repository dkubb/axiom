require 'spec_helper'
require File.expand_path('../../fixtures/classes', __FILE__)

describe 'Veritas::Immutable::ClassMethods#new' do
  subject { object.new }

  let(:object) { ImmutableSpecs::Object }

  it { should be_kind_of(object) }

  it { should be_frozen }
end
