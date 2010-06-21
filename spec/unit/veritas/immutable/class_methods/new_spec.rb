require 'spec_helper'
require File.expand_path('../../fixtures/classes', __FILE__)

describe 'Veritas::Immutable::ClassMethods#new' do
  subject { klass.new }

  let(:klass) { ImmutableSpecs::Object }

  it { should be_kind_of(klass) }

  it { should be_frozen }
end
