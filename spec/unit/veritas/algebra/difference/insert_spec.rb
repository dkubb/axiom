# encoding: utf-8

require 'spec_helper'

describe Algebra::Difference, '#insert' do
  subject { object.insert(other) }

  let(:object)         { described_class.new(left, right) }
  let(:left)           { Relation.new(header, [ [ 1 ] ])  }
  let(:right)          { Relation.new(header, [ [ 1 ] ])  }
  let(:other_relation) { Relation.new(header, [ [ 2 ] ])  }
  let(:header)         { [ [ :id, Integer ] ]             }

  shared_examples_for 'Algebra::Difference#insert' do
    it { should be_instance_of(described_class) }

    its(:left)  { should eql(left.insert(other_relation.difference(right))) }
    its(:right) { should eql(right)                                         }

    its(:header) { should == [ [ :id, Integer ] ] }

    it 'inserts the tuples' do
      should == [ [ 2 ] ]
    end
  end

  context 'with a relation' do
    let(:other) { other_relation }

    it_should_behave_like 'Algebra::Difference#insert'
  end

  context 'with an array of tuples' do
    let(:other) { other_relation.to_a }

    it_should_behave_like 'Algebra::Difference#insert'
  end

  context 'with an array of arrays' do
    let(:other) { other_relation.map(&:to_ary) }

    it_should_behave_like 'Algebra::Difference#insert'
  end
end
