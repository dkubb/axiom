# encoding: utf-8

require 'spec_helper'

describe Relation::Variable, '#insert' do
  subject { object.insert(other) }

  let(:object) { Relation::Variable.new(relation) }
  let(:other)  { [[2]]                            }
  let(:header) { [[:id, Integer]]                 }

  context 'with a materialized relation' do
    let(:relation) { Relation.new(header, [[1]]) }

    it { should == [[1], [2]] }

    it { should be_materialized }
  end

  context 'with a non-materialized relation' do
    let(:relation) { Relation::Base.new('users', header, [[1]]) }

    it { should == [[1], [2]] }

    it { should_not be_materialized }
  end
end
