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
