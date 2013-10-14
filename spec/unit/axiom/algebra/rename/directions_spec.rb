# encoding: utf-8

require 'spec_helper'

describe Algebra::Rename, '#directions' do
  subject { object.directions }

  let(:relation) { Relation.new([[:id, Integer]], LazyEnumerable.new) }
  let(:object)   { described_class.new(operand, id: :other_id)        }

  context 'containing a relation' do
    let(:operand) { relation }

    it_should_behave_like 'an idempotent method'

    it { should be_instance_of(Relation::Operation::Sorted::DirectionSet) }

    it { should be_empty }
  end

  context 'containing an sorted relation' do
    let(:operand) { relation.sort_by { [relation[:id]] } }

    it_should_behave_like 'an idempotent method'

    it { should be_instance_of(Relation::Operation::Sorted::DirectionSet) }

    it { should == [Attribute::Integer.new(:other_id).asc] }
  end
end
