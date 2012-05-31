# encoding: utf-8

require 'spec_helper'

describe Algebra::Union, '#delete' do
  subject { object.delete(other) }

  let(:object)         { described_class.new(left, right)       }
  let(:left)           { Relation.new(header, [ [ 1 ], [ 2 ] ]) }
  let(:right)          { Relation.new(header, [ [ 2 ], [ 3 ] ]) }
  let(:other_relation) { Relation.new(header, [ [ 2 ] ])        }
  let(:header)         { [ [ :id, Integer ] ]                   }

  shared_examples_for 'Algebra::Union#delete' do
    it { should be_instance_of(described_class) }

    its(:left)  { should eql(left.delete(other))  }
    its(:right) { should eql(right.delete(other)) }

    its(:header) { should == header }

    it 'deletes the tuples' do
      should == [ [ 1 ], [ 3 ] ]
    end
  end

  context 'with a relation' do
    let(:other) { other_relation }

    it_should_behave_like 'Algebra::Union#delete'
  end

  context 'with an array of tuples' do
    let(:other) { other_relation.to_a }

    it_should_behave_like 'Algebra::Union#delete'
  end

  context 'with an array of arrays' do
    let(:other) { other_relation.map(&:to_ary) }

    it_should_behave_like 'Algebra::Union#delete'
  end
end
