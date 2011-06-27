# encoding: utf-8

require 'spec_helper'
require File.expand_path('../../fixtures/classes', __FILE__)

describe Immutable::ClassMethods, '#new' do
  subject { object.new }

  let(:object) { ImmutableSpecs::Object }

  it { should be_instance_of(object) }

  it { should be_frozen }
end
