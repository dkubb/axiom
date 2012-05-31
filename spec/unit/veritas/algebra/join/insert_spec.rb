# encoding: utf-8

require 'spec_helper'

describe Algebra::Join, '#insert' do
  subject { object.insert(other) }

  let(:object)         { described_class.new(left, right)                          }
  let(:left)           { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])             }
  let(:right)          { Relation.new(header,               [ [ 1, 'John Doe' ] ]) }
  let(:other_relation) { Relation.new(header,               [ [ 2, 'Jane Doe' ] ]) }
  let(:header)         { [ [ :id, Integer ], [ :name, String ] ]                   }

  shared_examples_for 'Algebra::Join#insert' do
    it { should be_instance_of(described_class) }

    its(:left)  { should eql(left.insert(other_relation.project([ :id ])))         }
    its(:right) { should eql(right.insert(other_relation.project([ :id, :name ]))) }

    its(:header) { should == header }

    it 'inserts the tuples' do
      should == [ [ 1, 'John Doe' ], [ 2, 'Jane Doe' ] ]
    end
  end

  context 'with a relation' do
    let(:other) { other_relation }

    it_should_behave_like 'Algebra::Join#insert'
  end

  context 'with an array of tuples' do
    let(:other) { other_relation.to_a }

    it_should_behave_like 'Algebra::Join#insert'
  end

  context 'with an array of arrays' do
    let(:other) { other_relation.map(&:to_ary) }
    it_should_behave_like 'Algebra::Join#insert'
  end
end
