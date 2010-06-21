require 'spec_helper'

describe 'Veritas::Algebra::Projection#directions' do
  subject { projection.directions }

  let(:relation) { Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 1, 'Dan Kubb' ] ]) }

  context 'containing a relation' do
    let(:projection) { relation.project([ :id ]) }

    it { should be_kind_of(Relation::Operation::Order::DirectionSet) }

    it { should be_empty }

    it_should_behave_like 'an idempotent method'
  end

  context 'containing an ordered relation' do
    let(:order)      { relation.order { |r| r.header } }
    let(:projection) { order.project([ :id ])          }

    it { should be_kind_of(Relation::Operation::Order::DirectionSet) }

    it { should == [ order[:id].asc ] }

    it_should_behave_like 'an idempotent method'
  end
end
