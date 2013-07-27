# encoding: utf-8

require 'spec_helper'

describe Algebra::Restriction, '#predicate' do
  subject { object.predicate }

  let(:relation)  { Relation.new([[:id, Integer]], [[1]])    }
  let(:predicate) { relation[:id].ne(0)                      }
  let(:object)    { described_class.new(relation, predicate) }

  it_should_behave_like 'an idempotent method'

  it { should be(predicate) }
end
