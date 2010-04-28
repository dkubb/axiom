require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Predicate#hash' do
  before do
    @attribute = Attribute::Integer.new(:id)

    @predicate = PredicateSpecs::Object.new(@attribute, 1)
  end

  subject { @predicate.hash }

  it { should be_kind_of(Integer) }

  it { should == @attribute.hash ^ 1.hash }
end
