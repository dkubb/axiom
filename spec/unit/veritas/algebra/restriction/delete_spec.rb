# encoding: utf-8

require 'spec_helper'

describe Algebra::Restriction, '#delete' do
  subject { object.delete(other) }

  let(:object)    { described_class.new(relation, predicate)           }
  let(:relation)  { Relation.new([ attribute ], [ [ 1 ], [ 2 ] ].each) }
  let(:other)     { Relation.new([ attribute ], [ [ 0 ], [ 2 ] ].each) }
  let(:attribute) { Attribute::Integer.new(:id)                        }
  let(:predicate) { attribute.gte(1)                                   }

  it { should be_instance_of(described_class) }

  its(:operand) { should be_kind_of(Relation) }

  its(:predicate) { should equal(predicate) }

  it 'filters out tuples from the other relation not matching the predicate' do
    should == [ [ 1 ] ]
  end
end
