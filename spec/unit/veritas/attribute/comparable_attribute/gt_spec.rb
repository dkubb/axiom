require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Attribute::ComparableAttribute#gt' do
  before do
    @comparable = ComparableAttributeSpecs::Object.new(:object)
  end

  subject { @comparable.gt(1) }

  it { should be_kind_of(Algebra::Restriction::GreaterThan) }
end
