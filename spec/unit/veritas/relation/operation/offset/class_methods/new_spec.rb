require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Offset.new' do
  let(:original_relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ]) }

  subject { Relation::Operation::Offset.new(relation, 1) }

  context 'with an ordered relation' do
    let(:relation) { original_relation.order { |r| r[:id] } }

    it { should be_kind_of(Relation::Operation::Offset)  }
  end

  context 'without an ordered relation' do
    let(:relation) { original_relation }

    it { method(:subject).should raise_error(OrderedRelationRequiredError, 'can only offset an ordered relation') }
  end

  context 'with an offset less than 0' do
    let(:relation) { original_relation.order { |r| r[:id] } }

    subject { Relation::Operation::Offset.new(relation, -1) }

    it { method(:subject).should raise_error(InvalidOffsetError, 'offset must be greater than or equal to 0, but was -1') }
  end
end
