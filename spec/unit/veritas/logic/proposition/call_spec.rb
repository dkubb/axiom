require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Proposition#call' do
  subject { proposition.call }

  let(:proposition) { PropositionSpecs::Object.new }

  it 'calls self.class.call' do
    response = mock('#call response')
    PropositionSpecs::Object.should_receive(:call).and_return(response)
    should equal(response)
  end
end
