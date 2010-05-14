require 'spec_helper'

describe 'Veritas::Relation::Operation::Order::DirectionSet#project' do
  subject { directions.project([ header[:id] ]) }

  let(:header)     { Relation::Header.new([ [ :id, Integer ], [ :name, String ] ]) }
  let(:directions) { Relation::Operation::Order::DirectionSet.new(header)          }

  it { should_not be_equal(directions) }

  it { should be_kind_of(Relation::Operation::Order::DirectionSet) }

  it { should == [ header[:id] ] }
end
