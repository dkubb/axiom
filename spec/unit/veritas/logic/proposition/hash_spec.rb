require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Proposition#hash' do
  subject { proposition.hash }

  let(:proposition) { PropositionSpecs::Object.new }

  it 'hashes the results of self.class.eval' do
    response = mock('#eval response')
    PropositionSpecs::Object.should_receive(:eval).with(no_args).and_return(response)
    should == response.hash
  end
end
