require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Connective#inspect' do
  let(:connective) { ConnectiveSpecs::Object.new }

  subject { connective.inspect }

  it { method(:subject).should raise_error(NotImplementedError, 'ConnectiveSpecs::Object#inspect must be implemented') }
end
