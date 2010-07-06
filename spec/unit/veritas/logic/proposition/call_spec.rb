require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Proposition#call' do
  subject { proposition.call }

  let(:proposition) { PropositionSpecs::Object.new }

  it 'calls self.class.eval' do
    response = mock('#eval response')
    PropositionSpecs::Object.should_receive(:eval).and_return(response)
    should equal(response)
  end
end
