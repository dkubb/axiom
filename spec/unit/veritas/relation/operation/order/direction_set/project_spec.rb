require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order::DirectionSet#project' do
  let(:header)     { Relation::Header.new([ [ :id, Integer ], [ :name, String ] ]) }
  let(:directions) { Relation::Operation::Order::DirectionSet.new(header)          }

  subject { directions.project([ header[:id] ]) }

  it { should_not be_equal(directions) }

  it { should be_kind_of(Relation::Operation::Order::DirectionSet) }

  it { should == [ header[:id] ] }
end
