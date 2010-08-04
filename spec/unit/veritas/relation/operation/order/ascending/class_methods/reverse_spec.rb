require 'spec_helper'

describe 'Veritas::Relation::Operation::Order::Ascending.reverse' do
  subject { Relation::Operation::Order::Ascending.reverse }

  it { should equal(Relation::Operation::Order::Descending) }
end
