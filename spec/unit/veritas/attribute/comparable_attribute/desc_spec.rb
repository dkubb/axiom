require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Attribute::ComparableAttribute#desc' do
  before do
    @comparable = ComparableAttributeSpecs::Object.new(:object)
  end

  subject { @comparable.desc }

  it { should be_kind_of(Relation::Operation::Order::Descending) }
end
