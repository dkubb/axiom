# encoding: utf-8

require 'spec_helper'

describe Algebra::Rename, '#header' do
  subject { object.header }

  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:object)   { described_class.new(relation, id: :other_id)  }

  it_should_behave_like 'an idempotent method'

  it { should be_instance_of(Relation::Header) }

  it { should == [ [ :other_id, Integer ] ] }
end
