require File.expand_path('../../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Algebra::Restriction::Proposition#call' do
  before do
    @proposition = PropositionSpecs::Object.new
  end

  subject { @proposition.call }

  it 'should call self.class.eval' do
    response = mock('#eval response')
    PropositionSpecs::Object.should_receive(:eval).with(no_args).and_return(response)
    should equal(response)
  end
end
