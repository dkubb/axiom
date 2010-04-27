require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order::Ascending#invert' do
  before do
    @attribute = Attribute::Integer.new(:id)
    @ascending = Relation::Operation::Order::Ascending.new(@attribute)
  end

  subject { @ascending.invert }

  it { should be_kind_of(Relation::Operation::Order::Descending) }

  it 'sets the attribute' do
    subject.attribute.should equal(@attribute)
  end
end
