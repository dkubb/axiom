# encoding: utf-8

require 'spec_helper'

describe Algebra::Restriction, '#insert' do
  subject { object.insert(other) }

  let(:object)         { described_class.new(operand, predicate)                   }
  let(:operand)        { Relation.new([attribute], LazyEnumerable.new([[1]]))      }
  let(:other_relation) { Relation.new([attribute], LazyEnumerable.new([[0], [2]])) }
  let(:attribute)      { Attribute::Integer.new(:id)                               }
  let(:predicate)      { attribute.gte(1)                                          }

  shared_examples_for 'Algebra::Restrict#insert' do
    it { should be_instance_of(described_class) }

    its(:operand) { should be_kind_of(Relation::Operation::Insertion) }

    it 'passes expected relations into the insertion' do
      subject = self.subject.operand
      subject.left.should be(operand)
      subject.right.should be_kind_of(described_class)
      subject.right.predicate.should be(predicate)
    end

    its(:predicate) { should be(predicate) }

    it 'filters out tuples from the other relation not matching the predicate' do
      should == [[1], [2]]
    end
  end

  context 'with a relation' do
    let(:other) { other_relation }

    it_should_behave_like 'Algebra::Restrict#insert'
  end

  context 'with an array of tuples' do
    let(:other) { other_relation.to_a }

    it_should_behave_like 'Algebra::Restrict#insert'
  end

  context 'with an array of arrays' do
    let(:other) { other_relation.map(&:to_ary) }

    it_should_behave_like 'Algebra::Restrict#insert'
  end
end
