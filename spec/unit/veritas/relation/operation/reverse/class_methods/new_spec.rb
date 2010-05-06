require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Reverse.new' do
  let(:original_relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ]) }

  subject { Relation::Operation::Reverse.new(relation) }

  describe 'with an ordered relation' do
    let(:relation) { original_relation.order { |r| r[:id] } }

    it { should be_kind_of(Relation::Operation::Reverse) }

    it 'reverses the directions' do
      subject.directions.should == relation.directions.reverse
    end
  end

  describe 'without an ordered relation' do
    let(:relation) { original_relation }

    it { method(:subject).should raise_error(OrderedRelationRequiredError, 'can only reverse an ordered relation') }
  end
end
