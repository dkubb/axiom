# encoding: utf-8

require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Relation::Operation::Unary, '#directions' do
  subject { object.directions }

  let(:described_class) { UnaryOperationSpecs::Object                   }
  let(:relation)        { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:directions)      { relation.header                               }
  let(:order)           { relation.order { directions }                 }
  let(:object)          { described_class.new(order)                    }

  it_should_behave_like 'an idempotent method'

  it { should be_kind_of(Relation::Operation::Order::DirectionSet) }

  it { should == directions }
end
