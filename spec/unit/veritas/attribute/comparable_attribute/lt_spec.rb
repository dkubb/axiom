require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Attribute::ComparableAttribute#lt' do
  before do
    @comparable = ComparableAttributeSpecs::Object.new
  end

  subject { @comparable.lt(1) }

  it { should be_kind_of(Algebra::Restriction::LessThan) }
end
