# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Limit, '.new' do
  subject { object.new(relation, limit) }

  let(:original_relation) { Relation.new([[:id, Integer]], [[1], [2]]) }
  let(:object)            { described_class                            }

  context 'with a sorted relation' do
    let(:relation) { original_relation.sort_by { |r| r.id } }
    let(:limit)    { 1                                      }

    it { should be_instance_of(object) }
  end

  context 'with a sorted relation having an empty header' do
    let(:relation) { original_relation.sort_by { |r| r.id }.project([]) }
    let(:limit)    { 1                                                  }

    it { should be_instance_of(object) }
  end

  context 'without a sorted relation' do
    let(:relation) { original_relation }
    let(:limit)    { 1                 }

    specify { expect { subject }.to raise_error(SortededRelationRequiredError, 'can only limit a sorted operand') }
  end

  context 'with an limit less than 0' do
    let(:relation) { original_relation.sort_by { |r| r.id } }
    let(:limit)    { -1                                     }

    specify { expect { subject }.to raise_error(InvalidLimitError, 'limit must be greater than or equal to 0, but was -1') }
  end

  context 'with a nil limit' do
    let(:relation) { original_relation.sort_by { |r| r.id } }
    let(:limit)    { nil                                    }

    specify { expect { subject }.to raise_error(InvalidLimitError, 'limit must be greater than or equal to 0, but was nil') }
  end
end
