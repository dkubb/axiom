require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order::DirectionSet#attributes' do
  before do
    @attribute  = Attribute::Integer.new(:id)
    @directions = Relation::Operation::Order::DirectionSet.new([ @attribute ])
  end

  subject { @directions.attributes }

  it { should be_kind_of(Array) }

  it { should == [ @attribute ] }
end
