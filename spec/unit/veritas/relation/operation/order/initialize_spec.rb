require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order#initialize' do
  before do
    @relation   = Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ])
    @directions = [ @relation[:id] ]
  end

  subject { Relation::Operation::Order.new(@relation, @directions) }

  it 'should set the relation' do
    subject.relation.should equal(@relation)
  end

  it 'should set the directions' do
    subject.directions.should == [ @relation[:id].asc ]
  end
end
