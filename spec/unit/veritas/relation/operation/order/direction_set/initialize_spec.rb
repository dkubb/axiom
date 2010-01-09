require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order::DirectionSet#initialize' do
  before do
    @attribute  = Attribute::Integer.new(:id)
    @directions = [ @attribute ]
  end

  subject { Relation::Operation::Order::DirectionSet.new(@directions) }

  it { should be_kind_of(Relation::Operation::Order::DirectionSet) }

  it { subject.to_ary.should == [ @attribute.asc ] }
end
