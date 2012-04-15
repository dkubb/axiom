# encoding: utf-8

require 'spec_helper'
require File.expand_path('../../fixtures/classes', __FILE__)

describe Immutable::ModuleMethods, '#included' do
  subject { object.included(object) }

  let(:object) { ImmutableSpecs::Object }

  before do
    Immutable.should_receive(:included).with(object).and_return(Immutable)
  end

  it_should_behave_like 'a command method'
end
