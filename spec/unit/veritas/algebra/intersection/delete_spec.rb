# encoding: utf-8

require 'spec_helper'

describe Algebra::Intersection, '#delete' do
  subject { object.delete(other) }

  let(:object) { described_class.new(left, right)                     }
  let(:left)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ]) }
  let(:right)  { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ]) }
  let(:other)  { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])        }

  it { should be_instance_of(described_class) }

  its(:left)  { should eql(left.delete(other))  }
  its(:right) { should eql(right.delete(other)) }

  its(:header) { should == [ [ :id, Integer ] ] }

  it 'deletes the tuples' do
    should == [ [ 2 ] ]
  end
end
