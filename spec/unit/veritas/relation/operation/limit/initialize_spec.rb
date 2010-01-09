require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Limit#initialize' do
  before do
    @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ])
    @ordered  = @relation.order { |r| r[:id] }
  end

  subject { Relation::Operation::Limit.new(@ordered, 1) }

  it 'should set the relation' do
    subject.relation.should equal(@ordered)
  end

  it 'should set the limit' do
    subject.to_int.should == 1
  end
end
