require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Proposition#hash' do
  subject { proposition.hash }

  let(:proposition) { PropositionSpecs::Object.new }

  before do
    @response = mock('#call response')
    PropositionSpecs::Object.should_receive(:call).at_least(:once).and_return(@response)
  end

  it_should_behave_like 'an idempotent method'

  it 'hashes the results of self.class.call' do
    should == @response.hash
  end
end
