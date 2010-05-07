require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Proposition#inspect' do
  subject { proposition.inspect }

  let(:proposition) { PropositionSpecs::Object.new }

  specify { method(:subject).should raise_error(NotImplementedError, 'Veritas::Logic::Proposition.eval must be implemented') }
end
