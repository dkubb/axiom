# encoding: utf-8

require 'spec_helper'

describe Relation::Materialized, '.new' do
  let(:header) { Relation::Header.coerce([[:id, Integer]]) }
  let(:tuples) { [[1]]                                     }
  let(:object) { described_class                           }

  context 'with directions' do
    subject { object.new(header, tuples, directions) }

    let(:directions) { [header[:id]] }

    it { should be_instance_of(object) }

    its(:header) { should be(header) }

    its(:directions) do
      should be_instance_of(Relation::Operation::Sorted::DirectionSet)
      should == directions
    end

    it { should == tuples }
  end

  context 'with no directions' do
    subject { object.new(header, tuples) }

    it { should be_instance_of(object) }

    its(:header) { should be(header) }

    its(:directions) { should be(Relation::Operation::Sorted::DirectionSet::EMPTY) }

    it { should == tuples }
  end

  context 'with empty tuples and no directions' do
    subject { object.new(header, tuples) }

    let(:tuples) { [] }

    it { should be_instance_of(Relation::Empty) }

    its(:header) { should be(header) }

    its(:directions) { should be(Relation::Operation::Sorted::DirectionSet::EMPTY) }

    it { should be_empty }
  end

  context 'with no tuples or directions' do
    subject { object.new(header) }

    it { should be_instance_of(Relation::Empty) }

    its(:header) { should be(header) }

    its(:directions) { should be(Relation::Operation::Sorted::DirectionSet::EMPTY) }

    it { should be_empty }
  end

  context 'with no tuples or directions' do
    subject { object.new(header) }

    it { should be_instance_of(Relation::Empty) }

    its(:header) { should be(header) }

    its(:directions) { should be(Relation::Operation::Sorted::DirectionSet::EMPTY) }

    it { should be_empty }
  end
end
