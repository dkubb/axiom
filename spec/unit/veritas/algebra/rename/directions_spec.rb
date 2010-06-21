require 'spec_helper'

describe 'Veritas::Algebra::Rename#directions' do
  subject { rename.directions }

  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:aliases)  { { :id => :other_id }                          }

  context 'containing a relation' do
    let(:rename) { Algebra::Rename.new(relation, aliases) }

    it { should be_kind_of(Relation::Operation::Order::DirectionSet) }

    it { should be_empty }

    it_should_behave_like 'an idempotent method'
  end

  context 'containing an ordered relation' do
    let(:order)  { relation.order([ relation[:id] ])   }
    let(:rename) { Algebra::Rename.new(order, aliases) }

    it { should be_kind_of(Relation::Operation::Order::DirectionSet) }

    it { should == [ Attribute::Integer.new(:other_id).asc ] }

    it_should_behave_like 'an idempotent method'
  end
end
