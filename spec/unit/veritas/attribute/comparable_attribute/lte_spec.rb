require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Attribute::ComparableAttribute#lte' do
  before do
    @comparable = ComparableAttributeSpecs::Object.new(:object)
  end

  subject { @comparable.lte(1) }

  it { should be_kind_of(Algebra::Restriction::LessThanOrEqualTo) }
end
