require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order::Descending#invert' do
  subject { descending.invert }

  let(:attribute)  { Attribute::Integer.new(:id)                           }
  let(:descending) { Relation::Operation::Order::Descending.new(attribute) }

  it { should be_kind_of(Relation::Operation::Order::Ascending) }

  it 'sets the attribute' do
    subject.attribute.should equal(attribute)
  end
end
