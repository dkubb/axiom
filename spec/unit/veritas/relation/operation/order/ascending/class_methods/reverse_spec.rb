require 'spec_helper'

describe Relation::Operation::Order::Ascending, '.reverse' do
  subject { object.reverse }

  let(:object) { described_class }

  it { should equal(Relation::Operation::Order::Descending) }
end
