# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Reverse, '.new' do
  subject { object.new(relation) }

  let(:original_relation) { Relation.new([[:id, Integer]], [[1], [2]]) }
  let(:object)            { described_class                            }

  context 'with an ordered relation' do
    let(:relation) { original_relation.sort_by { |r| r.id } }

    it { should be_instance_of(object) }

    it 'reverses the directions' do
      expect(subject.directions).to eql(relation.directions.reverse)
    end
  end

  context 'with an ordered relation having an empty header' do
    let(:relation) { original_relation.sort_by { |r| r.id }.project([]) }

    it { should be_instance_of(object) }

    it 'reverses the directions' do
      expect(subject.directions).to eql(relation.directions.reverse)
    end
  end

  context 'without an ordered relation' do
    let(:relation) { original_relation }

    specify { expect { subject }.to raise_error(OrderedRelationRequiredError, 'can only reverse an ordered operand') }
  end
end
