require 'spec_helper'

describe Relation::Operation::Limit, '.new' do
  subject { object.new(relation, limit) }

  let(:original_relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ]) }
  let(:object)            { Relation::Operation::Limit                           }

  context 'with an ordered relation' do
    let(:relation) { original_relation.order { |r| r[:id] } }
    let(:limit)    { 1                                      }

    it { should be_kind_of(object) }
  end

  context 'with an ordered relation having an empty header' do
    let(:relation) { original_relation.order { |r| r[:id] }.project([]) }
    let(:limit)    { 1                                                  }

    it { should be_kind_of(object) }
  end

  context 'without an ordered relation' do
    let(:relation) { original_relation }
    let(:limit)    { 1                 }

    specify { expect { subject }.to raise_error(OrderedRelationRequiredError, 'can only limit an ordered operand') }
  end

  context 'with an limit less than 0' do
    let(:relation) { original_relation.order { |r| r[:id] } }
    let(:limit)    { -1                                     }

    specify { expect { subject }.to raise_error(InvalidLimitError, 'limit must be greater than or equal to 0, but was -1') }
  end
end
