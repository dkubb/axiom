require 'spec_helper'

describe 'Veritas::Relation::Operation::Limit.new' do
  subject { Relation::Operation::Limit.new(relation, limit) }

  let(:original_relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ]) }

  context 'with an ordered relation' do
    let(:relation) { original_relation.order { |r| r[:id] } }
    let(:limit)    { 1                                      }

    it { should be_kind_of(Relation::Operation::Limit) }
  end

  context 'without an ordered relation' do
    let(:relation) { original_relation }
    let(:limit)    { 1                 }

    specify { method(:subject).should raise_error(OrderedRelationRequiredError, 'can only limit an ordered relation') }
  end

  context 'with an limit less than 0' do
    let(:relation) { original_relation.order { |r| r[:id] } }
    let(:limit)    { -1                                     }

    specify { method(:subject).should raise_error(InvalidLimitError, 'limit must be greater than or equal to 0, but was -1') }
  end
end
