# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Offset, '.new' do
  subject { object.new(relation, offset) }

  let(:original_relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ]) }
  let(:object)            { described_class                                      }

  context 'with an ordered relation' do
    let(:relation) { original_relation.order { |r| r[:id] } }
    let(:offset)   { 1                                      }

    it { should be_kind_of(object) }
  end

  context 'with an ordered relation having an empty header' do
    let(:relation) { original_relation.order { |r| r[:id] }.project([]) }
    let(:offset)   { 1                                                  }

    it { should be_kind_of(object) }
  end

  context 'without an ordered relation' do
    let(:relation) { original_relation }
    let(:offset)   { 1                 }

    specify { expect { subject }.to raise_error(OrderedRelationRequiredError, 'can only offset an ordered operand') }
  end

  context 'with an offset less than 0' do
    let(:relation) { original_relation.order { |r| r[:id] } }
    let(:offset)   { -1                                     }

    specify { expect { subject }.to raise_error(InvalidOffsetError, 'offset must be greater than or equal to 0, but was -1') }
  end

  context 'with a nil offset' do
    let(:relation) { original_relation.order { |r| r[:id] } }
    let(:offset)   { nil                                    }

    specify { expect { subject }.to raise_error(InvalidOffsetError, 'offset must be greater than or equal to 0, but was nil') }
  end
end
