# encoding: utf-8

require 'spec_helper'

describe Algebra::Join, '#insert' do
  subject { object.insert(other) }

  let(:object) { described_class.new(left, right)                                             }
  let(:left)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])                                }
  let(:right)  { Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 1, 'John Doe' ] ]) }
  let(:other)  { Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 2, 'Jane Doe' ] ]) }

  it { should be_instance_of(described_class) }

  its(:left)  { should eql(left.insert(other.project([ :id ])))         }
  its(:right) { should eql(right.insert(other.project([ :id, :name ]))) }

  its(:header) { should == [ [ :id, Integer ], [ :name, String ] ] }

  it 'inserts the tuples' do
    should == [ [ 1, 'John Doe' ], [ 2, 'Jane Doe' ] ]
  end
end
