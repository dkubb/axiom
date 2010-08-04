require 'spec_helper'

describe 'Veritas::Relation::Operation::Order::Descending.reverse' do
  subject { Relation::Operation::Order::Descending.reverse }

  it { should equal(Relation::Operation::Order::Ascending) }
end
