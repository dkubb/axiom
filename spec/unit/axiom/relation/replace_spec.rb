# encoding: utf-8

require 'spec_helper'

describe Relation, '#replace' do
  subject { object.replace(other) }

  let(:object)         { described_class.new(header, [ [ 1 ] ]) }
  let(:other_relation) { described_class.new(header, [ [ 2 ] ]) }
  let(:header)         { [ [ :id, Integer ] ]                   }

  shared_examples_for 'Relation#replace' do
    it { should be_instance_of(Relation::Operation::Insertion) }

    its(:header) { should == header }

    it 'returns the expected tuples' do
      should == other
    end

    it 'applies the left operations in the correct sequence' do
      subject = self.subject.left
      subject.should be_instance_of(Relation::Operation::Deletion)
      subject.left.should equal(object)
      subject.right.should be_instance_of(Algebra::Difference)
      subject.right.left.should equal(object)
      subject.right.right.should eql(other_relation)
    end

    it 'applies the right operations in the correct sequence' do
      subject = self.subject.right
      subject.should be_instance_of(Algebra::Difference)
      subject.left.should eql(other_relation)
      subject.right.should equal(object)
    end
  end

  context 'with a relation' do
    let(:other) { other_relation }

    it_should_behave_like 'Relation#replace'
  end

  context 'with an array of tuples' do
    let(:other) { other_relation.to_a }

    it_should_behave_like 'Relation#replace'
  end

  context 'with an array of arrays' do
    let(:other) { other_relation.map(&:to_ary) }

    it_should_behave_like 'Relation#replace'
  end
end
