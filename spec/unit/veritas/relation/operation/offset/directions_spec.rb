# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Offset, '#directions' do
  subject { object.directions }

  let(:relation) { Relation.new([ [ :id, Integer ] ], [].each) }
  let(:object)   { described_class.new(ordered, 0)             }
  let(:ordered)  { relation.order                              }

  it_should_behave_like 'an idempotent method'

  it { should equal(ordered.directions) }
end
