require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order::DirectionSet#to_ary' do
  before do
    @attribute  = Attribute::Integer.new(:id)
    @directions = Relation::Operation::Order::DirectionSet.new([ @attribute ])
  end

  subject { @directions.to_ary }

  it { should be_instance_of(Array) }

  it { should == [ @attribute.asc ] }
end
