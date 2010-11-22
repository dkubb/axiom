require 'spec_helper'

describe 'Veritas::Relation::Operation::Order::Ascending.reverse' do
  subject { object.reverse }

  let(:object) { Relation::Operation::Order::Ascending }

  it { should equal(Relation::Operation::Order::Descending) }
end
