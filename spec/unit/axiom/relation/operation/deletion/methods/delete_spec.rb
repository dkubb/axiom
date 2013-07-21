# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Deletion::Methods, '#insert' do
  subject { object.delete(other) }

  let(:object) { Relation.new([[:id, Integer]], [[1], [2]]) }
  let(:tuples) { [[1]]                                      }

  context 'when other is a Relation' do
    let(:other) { Relation.new([[:id, Integer]], tuples) }

    it { should be_instance_of(Relation::Operation::Deletion) }

    its(:left) { should be(object) }

    its(:right) { should be(other) }

    it 'returns the expected tuples' do
      should == [[2]]
    end
  end

  context 'when other is an Enumerable' do
    let(:other) { tuples }

    it { should be_instance_of(Relation::Operation::Deletion) }

    its(:left) { should be(object) }

    its(:right) { should_not be(other) }

    its(:right) { should be_kind_of(Relation) }

    its(:right) { should == other }

    it 'returns the expected tuples' do
      should == [[2]]
    end
  end
end
