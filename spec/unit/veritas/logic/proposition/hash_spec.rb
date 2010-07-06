require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Proposition#hash' do
  subject { proposition.hash }

  let(:proposition) { PropositionSpecs::Object.new }

  before do
    @response = mock('#eval response')
    PropositionSpecs::Object.should_receive(:eval).at_least(:once).and_return(@response)
  end

  it 'hashes the results of self.class.eval' do
    should == @response.hash
  end

  it_should_behave_like 'an idempotent method'
end
