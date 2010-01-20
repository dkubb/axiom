require File.expand_path('../../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Algebra::Restriction::Proposition#invert' do
  before do
    @proposition = PropositionSpecs::Object.new
  end

  subject { @proposition.invert }

  it { method(:subject).should raise_error(NotImplementedError, 'Veritas::Algebra::Restriction::Proposition#invert must be implemented') }
end
