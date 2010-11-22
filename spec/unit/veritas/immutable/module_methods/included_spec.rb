require 'spec_helper'
require File.expand_path('../../fixtures/classes', __FILE__)

describe 'Veritas::Immutable::ModuleMethods#included' do
  subject { object.included(object) }

  let(:object) { ImmutableSpecs::Object }

  before do
    Immutable.should_receive(:included).with(object).and_return(Immutable)
  end

  it { should equal(object) }
end
