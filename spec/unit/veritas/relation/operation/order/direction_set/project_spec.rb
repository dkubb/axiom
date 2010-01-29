require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order::DirectionSet#project' do
  before do
    @header     = Relation::Header.new([ [ :id, Integer ], [ :name, String ] ])
    @directions = Relation::Operation::Order::DirectionSet.new(@header)
  end

  subject { @directions.project([ @header[:id] ]) }

  it { should_not be_equal(@directions) }

  it { should be_kind_of(Relation::Operation::Order::DirectionSet) }

  it { should == [ @header[:id] ] }
end
