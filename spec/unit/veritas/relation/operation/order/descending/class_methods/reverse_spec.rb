require 'spec_helper'

describe Relation::Operation::Order::Descending, '.reverse' do
  subject { object.reverse }

  let(:object) { Relation::Operation::Order::Descending }

  it { should equal(Relation::Operation::Order::Ascending) }
end
