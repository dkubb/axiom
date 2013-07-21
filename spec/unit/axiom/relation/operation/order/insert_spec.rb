# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Order, '#insert' do
  subject { object.insert(other) }

  let(:object)     { described_class.new(relation, directions)            }
  let(:relation)   { Relation.new([attribute], LazyEnumerable.new([[1]])) }
  let(:attribute)  { Attribute::Integer.new(:id)                          }
  let(:directions) { [attribute.desc]                                     }

  context 'when other relation has matching directions' do
    let(:other)      { other_base.sort_by(directions)                       }
    let(:other_base) { Relation.new([attribute], LazyEnumerable.new([[2]])) }

    it { should be_instance_of(described_class) }

    its(:operand) { should be_kind_of(Relation::Operation::Insertion) }

    it 'passes expected relations into the insertion' do
      subject = self.subject.operand
      subject.left.should equal(relation)
      subject.right.should equal(other_base)
    end

    its(:directions) { should == directions }

    it 'inserts the tuples' do
      should == [[2], [1]]
    end
  end

  context 'when other relation does not have the same directions' do
    let(:other) { Relation.new([attribute], LazyEnumerable.new([[2]])).sort_by([attribute]) }

    specify { expect { subject }.to raise_error(OrderMismatchError, 'other relation must have matching directions to be inserted') }
  end

  context 'when other relation is not an order' do
    let(:other) { Relation.new([attribute], LazyEnumerable.new([[2]])) }

    specify { expect { subject }.to raise_error(OrderMismatchError, 'other relation must have matching directions to be inserted') }
  end
end
