require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order::Body#initialize' do
  before do
    @header = Relation::Header.new([ [ :id, Integer ] ])
    @tuples = (0..10).map { |index| [ index ] }
  end

  subject { Relation::Operation::Order::Body.new(@header, @tuples) }

  it { should be_kind_of(Relation::Body) }

  it { should be_kind_of(Relation::Operation::Order::Body) }

  it { subject.header.should equal(@header) }

  it 'should match the tuples in order' do
    subject.to_a.should == @tuples
  end
end
