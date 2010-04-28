require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Proposition#inspect' do
  before do
    @proposition = PropositionSpecs::Object.new
  end

  subject { @proposition.inspect }

  it { method(:subject).should raise_error(NotImplementedError, 'Veritas::Logic::Proposition.eval must be implemented') }
end
