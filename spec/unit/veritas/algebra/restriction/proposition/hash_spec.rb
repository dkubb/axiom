require File.expand_path('../../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Algebra::Restriction::Proposition#hash' do
  before do
    @proposition = PropositionSpecs::Object.new
  end

  subject { @proposition.hash }

  it 'should hash the resutls of self.class.eval' do
    response = mock('#eval response')
    PropositionSpecs::Object.should_receive(:eval).with(no_args).and_return(response)
    should == response.hash
  end
end
