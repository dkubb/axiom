require 'spec_helper'

describe 'Veritas::Relation::Operation::Order::Descending#reverse' do
  subject { object.reverse }

  let(:klass)     { Relation::Operation::Order::Descending }
  let(:attribute) { Attribute::Integer.new(:id)            }
  let(:object)    { klass.new(attribute)                   }

  it { should be_kind_of(Relation::Operation::Order::Ascending) }

  its(:attribute) { should equal(attribute) }
end
