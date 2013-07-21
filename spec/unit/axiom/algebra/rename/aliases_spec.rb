# encoding: utf-8

require 'spec_helper'

describe Algebra::Rename, '#aliases' do
  subject { object.aliases }

  let(:relation) { Relation.new([[:id, Integer]], [[1]])                                          }
  let(:aliases)  { described_class::Aliases.new(relation[:id] => relation[:id].rename(:other_id)) }
  let(:object)   { described_class.new(relation, aliases)                                         }

  it { should equal(aliases) }
end
