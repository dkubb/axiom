require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order::DirectionSet#rename' do
  before do
    @attribute  = Attribute::Integer.new(:id)
    @directions = Relation::Operation::Order::DirectionSet.new([ @attribute ])

    @aliases = { :id => :other_id }
  end

  subject { @directions.rename(@aliases) }

  it { should_not be_equal(@directions) }

  it { should be_kind_of(Relation::Operation::Order::DirectionSet) }

  it { should == [ Attribute::Integer.new(:other_id) ] }
end
