# encoding: utf-8

require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Relation::Operation::Set, '#header' do
  subject { object.header }

  let(:described_class) { SetOperationSpecs::Object                     }
  let(:left)            { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:right)           { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:object)          { described_class.new(left, right)              }

  it_should_behave_like 'an idempotent method'

  it { should equal(left.header) }
end
