require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#directions' do
  subject { relation.directions }

  let(:relation) { Relation.new([ [ :id, Integer ] ], []) }

  it { should be_kind_of(Relation::Operation::Order::DirectionSet) }

  it { should be_empty }

  it 'is consistent' do
    should equal(relation.directions)
  end
end
