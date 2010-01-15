require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order::DirectionSet#union' do
  before do
    @attribute1 = Attribute::Integer.new(:id)
    @attribute2 = Attribute::String.new(:name)

    @directions = Relation::Operation::Order::DirectionSet.new([ @attribute1 ])
    @other      = Relation::Operation::Order::DirectionSet.new([ @attribute2 ])
  end

  subject { @directions.union(@other) }

  it { should be_kind_of(Relation::Operation::Order::DirectionSet) }

  it { should == [ @attribute1.asc, @attribute2.asc ] }
end

describe 'Veritas::Relation::Operation::Order::DirectionSet#|' do
  it 'is an alias to #union' do
    klass = Relation::Operation::Order::DirectionSet
    klass.instance_method(:|).should == klass.instance_method(:union)
  end
end
