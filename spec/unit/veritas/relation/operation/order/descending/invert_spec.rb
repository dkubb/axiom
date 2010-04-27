require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order::Descending#invert' do
  before do
    @attribute  = Attribute::Integer.new(:id)
    @descending = Relation::Operation::Order::Descending.new(@attribute)
  end

  subject { @descending.invert }

  it { should be_kind_of(Relation::Operation::Order::Ascending) }

  it 'sets the attribute' do
    subject.attribute.should equal(@attribute)
  end
end
