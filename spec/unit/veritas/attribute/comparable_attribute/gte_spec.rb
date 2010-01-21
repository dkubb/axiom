require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Attribute::ComparableAttribute#gte' do
  before do
    @comparable = ComparableAttributeSpecs::Object.new
  end

  subject { @comparable.gte(1) }

  it { should be_kind_of(Algebra::Restriction::GreaterThanOrEqualTo) }
end
