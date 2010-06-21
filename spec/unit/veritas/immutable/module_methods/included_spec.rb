require 'spec_helper'
require File.expand_path('../../fixtures/classes', __FILE__)

describe 'Veritas::Immutable::ModuleMethods#included' do
  subject { klass.included(klass) }

  let(:klass) { ImmutableSpecs::Object }

  before do
    Veritas::Immutable.should_receive(:included).with(klass).and_return(Veritas::Immutable)
  end

  it { should equal(Veritas::Immutable) }
end
