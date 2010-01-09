require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order::DirectionSet#hash' do
  before do
    @attribute  = Attribute::Integer.new(:id)
    @directions = Relation::Operation::Order::DirectionSet.new([ @attribute ])
  end

  subject { @directions.hash }

  it { should be_kind_of(Integer) }

  it { should == [ @attribute.asc ].hash }
end
