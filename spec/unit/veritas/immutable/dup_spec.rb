require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Immutable#dup' do
  subject { immutable.dup }

  let(:klass)     { ImmutableSpecs::Object }
  let(:immutable) { klass.new              }

  it { should equal(immutable) }
end
