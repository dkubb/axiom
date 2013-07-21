# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Order, '#directions' do
  subject { object.directions }

  let(:relation)   { Relation.new([[:id, Integer]], LazyEnumerable.new)    }
  let(:directions) { described_class::DirectionSet.coerce(relation.header) }
  let(:object)     { described_class.new(relation, directions)             }

  it_should_behave_like 'an idempotent method'

  it { should equal(directions) }
end
