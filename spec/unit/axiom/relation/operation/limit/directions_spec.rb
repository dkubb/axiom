# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Limit, '#directions' do
  subject { object.directions }

  let(:relation) { Relation.new([[:id, Integer]], LazyEnumerable.new) }
  let(:object)   { described_class.new(ordered, 1)                    }
  let(:ordered)  { relation.sort_by { |r| r.id }                      }

  it_should_behave_like 'an idempotent method'

  it { should equal(ordered.directions) }
end
