# encoding: utf-8

require 'spec_helper'

describe Relation::Variable, '#delete' do
  subject { object.delete(other) }

  let(:object) { Relation::Variable.new(relation) }
  let(:other)  { [[1]]                            }
  let(:header) { [[:id, Integer]]                 }

  context 'with a materialized relation' do
    let(:relation) { Relation.new(header, [[1]]) }

    it { should be_empty }

    it { should be_materialized }
  end

  context 'with a non-materialized relation' do
    let(:relation) { Relation::Base.new('users', header, [[1]]) }

    it { should be_empty }

    it { should_not be_materialized }
  end
end
