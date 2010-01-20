require File.expand_path('../../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Algebra::Restriction::Connective#inspect' do
  before do
    @connective = ConnectiveSpecs::Object.new
  end

  subject { @connective.inspect }

  it { method(:subject).should raise_error(NotImplementedError, 'ConnectiveSpecs::Object#inspect must be implemented') }
end
