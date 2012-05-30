# encoding: utf-8

require 'spec_helper'

describe Algebra::Union, '#insert' do
  subject { object.insert(other) }

  let(:object) { described_class.new(left, right)              }
  let(:left)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:right)  { Relation.new([ [ :id, Integer ] ], [ [ 2 ] ]) }
  let(:other)  { Relation.new([ [ :id, Integer ] ], [ [ 3 ] ]) }

  it { should be_instance_of(described_class) }

  its(:left)  { should eql(left.insert(other))  }
  its(:right) { should eql(right.insert(other)) }

  its(:header) { should == [ [ :id, Integer ] ] }

  it 'inserts the tuples' do
    should == [ [ 1 ], [ 2 ], [ 3 ] ]
  end
end
