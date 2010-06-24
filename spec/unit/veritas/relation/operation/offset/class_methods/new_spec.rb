require 'spec_helper'

describe 'Veritas::Relation::Operation::Offset.new' do
  subject { Relation::Operation::Offset.new(relation, offset) }

  let(:original_relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ]) }

  context 'with an ordered relation' do
    let(:relation) { original_relation.order { |r| r[:id] } }
    let(:offset)   { 1                                      }

    it { should be_kind_of(Relation::Operation::Offset) }
  end

  context 'without an ordered relation' do
    let(:relation) { original_relation }
    let(:offset)   { 1                 }

    specify { expect { subject }.to raise_error(OrderedRelationRequiredError, 'can only offset an ordered relation') }
  end

  context 'with an offset less than 0' do
    let(:relation) { original_relation.order { |r| r[:id] } }
    let(:offset)   { -1                                     }

    specify { expect { subject }.to raise_error(InvalidOffsetError, 'offset must be greater than or equal to 0, but was -1') }
  end
end
