require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Rename#directions' do
  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:aliases)  { { :id => :other_id }                          }

  subject { rename.directions }

  context 'containing a relation' do
    let(:rename) { Algebra::Rename.new(relation, aliases) }

    it { should be_kind_of(Relation::Operation::Order::DirectionSet) }

    it { should be_empty }

    it 'is consistent' do
      should equal(rename.directions)
    end
  end

  context 'containing an ordered relation' do
    let(:order)  { relation.order([ relation[:id] ])   }
    let(:rename) { Algebra::Rename.new(order, aliases) }

    it { should be_kind_of(Relation::Operation::Order::DirectionSet) }

    it { should == [ Attribute::Integer.new(:other_id).asc ] }

    it 'is consistent' do
      should equal(rename.directions)
    end
  end
end
