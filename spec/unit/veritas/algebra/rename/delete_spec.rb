# encoding: utf-8

require 'spec_helper'

describe Algebra::Rename, '#delete' do
  subject { object.delete(other) }

  let(:object)         { described_class.new(operand, aliases)                      }
  let(:operand)        { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ].each)  }
  let(:other_relation) { Relation.new(header,               [ [ 2 ]        ].each)  }
  let(:aliases)        { described_class::Aliases.coerce(operand, :id => :other_id) }
  let(:header)         { [ [ :other_id, Integer ] ]                                 }

  shared_examples_for 'Algebra::Rename#delete' do
    it { should be_instance_of(described_class) }

    its(:operand) { should be_kind_of(Relation) }

    its(:header) { should == header }

    its(:aliases) { should eql(aliases) }

    it 'deletes the tuples' do
      should == [ [ 1 ] ]
    end
  end

  context 'with a relation' do
    let(:other) { other_relation }

    it_should_behave_like 'Algebra::Rename#delete'
  end

  context 'with an array of tuples' do
    let(:other) { other_relation.to_a }

    it_should_behave_like 'Algebra::Rename#delete'
  end

  context 'with an array of arrays' do
    let(:other) { other_relation.map(&:to_ary) }

    it_should_behave_like 'Algebra::Rename#delete'
  end
end
