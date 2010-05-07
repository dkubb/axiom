require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Proposition#inspect' do
  let(:proposition) { PropositionSpecs::Object.new }

  subject { proposition.inspect }

  specify { method(:subject).should raise_error(NotImplementedError, 'Veritas::Logic::Proposition.eval must be implemented') }
end
