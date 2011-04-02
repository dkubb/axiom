require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Relation::Operation::Unary, '#directions' do
  subject { object.directions }

  let(:described_class) { UnaryOperationSpecs::Object                                   }
  let(:relation)        { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])                 }
  let(:directions)      { Relation::Operation::Order::DirectionSet.new(relation.header) }
  let(:order)           { relation.order(directions)                                    }
  let(:object)          { described_class.new(order)                                    }

  it_should_behave_like 'an idempotent method'

  it { should equal(directions) }
end
