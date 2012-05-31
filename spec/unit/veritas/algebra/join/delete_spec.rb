# encoding: utf-8

require 'spec_helper'

describe Algebra::Join, '#delete' do
  subject { object.delete(other) }

  let(:object)         { described_class.new(left, right)                                                                }
  let(:left)           { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ])                                            }
  let(:right)          { Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 1, 'John Doe' ], [ 2, 'Jane Doe' ] ]) }
  let(:other_relation) { Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 1, 'John Doe' ] ])                    }

  shared_examples_for 'Algebra::Join#delete' do
    it { should be_instance_of(described_class) }

    its(:left)  { should eql(left.delete(other_relation.project([ :id ])))         }
    its(:right) { should eql(right.delete(other_relation.project([ :id, :name ]))) }

    its(:header) { should == [ [ :id, Integer ], [ :name, String ] ] }

    it 'deletes the tuples' do
      should == [ [ 2, 'Jane Doe' ] ]
    end
  end

  context 'with a relation' do
    let(:other) { other_relation }

    it_should_behave_like 'Algebra::Join#delete'
  end

  context 'with an array of tuples' do
    let(:other) { other_relation.to_a }

    it_should_behave_like 'Algebra::Join#delete'
  end

  context 'with an array of arrays' do
    let(:other) { other_relation.map(&:to_ary) }
    it_should_behave_like 'Algebra::Join#delete'
  end
end
