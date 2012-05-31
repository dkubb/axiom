# encoding: utf-8

require 'spec_helper'

describe Algebra::Join, '#delete' do
  subject { object.delete(other) }

  let(:object) { described_class.new(left, right)                                                                }
  let(:left)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ])                                            }
  let(:right)  { Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 1, 'John Doe' ], [ 2, 'Jane Doe' ] ]) }
  let(:other)  { Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 1, 'John Doe' ] ])                    }

  it { should be_instance_of(described_class) }

  its(:left)  { should eql(left.delete(other.project([ :id ])))         }
  its(:right) { should eql(right.delete(other.project([ :id, :name ]))) }

  its(:header) { should == [ [ :id, Integer ], [ :name, String ] ] }

  it 'deletes the tuples' do
    should == [ [ 2, 'Jane Doe' ] ]
  end
end
