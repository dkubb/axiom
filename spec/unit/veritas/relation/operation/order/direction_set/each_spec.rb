require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order::DirectionSet' do
  before do
    @attributes = [ Attribute::Integer.new(:id) ]
  end

  subject { Relation::Operation::Order::DirectionSet.new(@attributes) }

  it { should be_kind_of(Enumerable) }

  it 'case matches Enumerable' do
    (Enumerable === subject).should be_true
  end
end

describe 'Veritas::Relation::Operation::Order::DirectionSet#each' do
  before do
    @attributes = [ Attribute::Integer.new(:id), Attribute::String.new(:name) ]
    @directions = Relation::Operation::Order::DirectionSet.new(@attributes)

    @yield = []
  end

  subject { @directions.each { |direction| @yield << direction } }

  it { should equal(@directions) }

  it 'yields each direction' do
    method(:subject).should change { @yield.dup }.from([]).to(@directions.to_ary)
  end
end
