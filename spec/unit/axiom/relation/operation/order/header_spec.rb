# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Order, '#header' do
  subject { object.header }

  let(:header)   { Relation::Header.coerce([[:id, Integer]]) }
  let(:relation) { Relation.new(header, [[1], [2]])          }
  let(:object)   { described_class.new(relation, header)     }

  it_should_behave_like 'an idempotent method'

  it { should be(header) }
end
