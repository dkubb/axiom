require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order::Body#limit' do
  before do
    @header = Relation::Header.new([ [ :id, Integer ] ])
    @tuples = (10..15).map { |index| [ index ] }

    @body = Relation::Operation::Order::Body.new(@tuples, @header)
  end

  subject { @body.limit(1) }

  it { should be_kind_of(Relation::Operation::Order::Body) }

  it { should == [ [ 10 ] ] }
end
