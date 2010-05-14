require 'spec_helper'

describe 'Veritas::Relation::Operation::Order::Descending#reverse' do
  subject { descending.reverse }

  let(:attribute)  { Attribute::Integer.new(:id)                           }
  let(:descending) { Relation::Operation::Order::Descending.new(attribute) }

  it { should be_kind_of(Relation::Operation::Order::Ascending) }

  its(:attribute) { should equal(attribute) }
end
