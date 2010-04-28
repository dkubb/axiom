require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Predicate#inspect' do
  before do
    @attribute = Attribute::Integer.new(:id)

    @predicate = PredicateSpecs::Object.new(@attribute, 1)
  end

  subject { @predicate.inspect }

  it { method(:subject).should raise_error(NotImplementedError, 'Veritas::Logic::Predicate#inspect must be implemented') }
end
