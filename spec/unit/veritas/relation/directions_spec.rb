require 'spec_helper'

describe 'Veritas::Relation#directions' do
  subject { relation.directions }

  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }

  it { should be_kind_of(Relation::Operation::Order::DirectionSet) }

  it { should be_empty }

  it_should_behave_like 'an idempotent method'
end
