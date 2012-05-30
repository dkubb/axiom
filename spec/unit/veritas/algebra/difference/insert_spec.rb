# encoding: utf-8

require 'spec_helper'

describe Algebra::Difference, '#insert' do
  subject { object.insert(other) }

  let(:object) { described_class.new(left, right)              }
  let(:left)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:right)  { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:other)  { Relation.new([ [ :id, Integer ] ], [ [ 2 ] ]) }

  it { should be_instance_of(described_class) }

  its(:left)  { should eql(left.insert(other))  }
  its(:right) { should eql(right.delete(other)) }

  its(:header) { should == [ [ :id, Integer ] ] }

  it 'inserts the tuples' do
    should == [ [ 2 ] ]
  end
end
