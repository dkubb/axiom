require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order::Ascending#reverse' do
  subject { ascending.reverse }

  let(:attribute) { Attribute::Integer.new(:id)                          }
  let(:ascending) { Relation::Operation::Order::Ascending.new(attribute) }

  it { should be_kind_of(Relation::Operation::Order::Descending) }

  it 'sets the attribute' do
    subject.attribute.should equal(attribute)
  end
end
