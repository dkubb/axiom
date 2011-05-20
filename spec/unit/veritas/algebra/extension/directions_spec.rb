# encoding: utf-8

require 'spec_helper'

describe Algebra::Extension, '#directions' do
  subject { object.directions }

  let(:relation) { Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 1, 'Dan Kubb' ] ]) }
  let(:object)   { described_class.new(operand, {})                                             }

  context 'containing an unordered relation' do
    let(:operand) { relation }

    it_should_behave_like 'an idempotent method'

    it { should equal(Relation::Operation::Order::DirectionSet::EMPTY) }
  end

  context 'containing an ordered relation' do
    let(:operand) { relation.order }

    it_should_behave_like 'an idempotent method'

    it { should equal(Relation::Operation::Order::DirectionSet::EMPTY) }
  end
end
