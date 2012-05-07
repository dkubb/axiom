# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Insertion::Methods, '#insert' do
  subject { object.insert(other) }

  let(:object) { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:tuples) { [ [ 2 ] ]                                     }

  context 'when other is a Relation' do
    let(:other) { Relation.new([ [ :id, Integer ] ], tuples) }

    it { should be_instance_of(Relation::Operation::Insertion) }

    its(:left) { should be(object) }

    its(:right) { should be(other) }

    it 'returns the expected tuples' do
      should == [ [ 1 ], [ 2 ] ]
    end
  end

  context 'when other is an Enumerable' do
    let(:other) { tuples }

    it { should be_instance_of(Relation::Operation::Insertion) }

    its(:left) { should be(object) }

    its(:right) { should_not be(other) }

    its(:right) { should be_kind_of(Relation) }

    its(:right) { should == other }

    it 'returns the expected tuples' do
      should == [ [ 1 ], [ 2 ] ]
    end
  end
end
