require 'spec_helper'

describe Relation::Operation::Order::Ascending, '#reverse' do
  subject { object.reverse }

  let(:klass)     { Relation::Operation::Order::Ascending }
  let(:attribute) { Attribute::Integer.new(:id)           }
  let(:object)    { klass.new(attribute)                  }

  it { should be_kind_of(Relation::Operation::Order::Descending) }

  its(:attribute) { should equal(attribute) }
end
