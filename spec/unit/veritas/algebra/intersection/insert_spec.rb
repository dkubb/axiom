# encoding: utf-8

require 'spec_helper'

describe Algebra::Intersection, '#insert' do
  subject { object.insert(other) }

  let(:object)         { described_class.new(left, right)              }
  let(:left)           { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:right)          { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:other_relation) { Relation.new([ [ :id, Integer ] ], [ [ 2 ] ]) }

  shared_examples_for 'Algebra::Intersection#insert' do
    it { should be_instance_of(described_class) }

    its(:left)  { should eql(left.insert(other))  }
    its(:right) { should eql(right.insert(other)) }

    its(:header) { should == [ [ :id, Integer ] ] }

    it 'inserts the tuples' do
      should == [ [ 1 ], [ 2 ] ]
    end
  end

  context 'with a relation' do
    let(:other) { other_relation }

    it_should_behave_like 'Algebra::Intersection#insert'
  end

  context 'with an array of tuples' do
    let(:other) { other_relation.to_a }

    it_should_behave_like 'Algebra::Intersection#insert'
  end

  context 'with an array of arrays' do
    let(:other) { other_relation.map(&:to_ary) }

    it_should_behave_like 'Algebra::Intersection#insert'
  end
end
