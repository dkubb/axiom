require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction#initialize' do
  before do
    @relation  = Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])
    @predicate = @relation[:id].eq(1)
  end

  subject { Algebra::Restriction.new(@relation, @predicate) }

  it 'should set the relation' do
    subject.relation.should equal(@relation)
  end

  it 'should set the body' do
    subject.body.should == [ [ 1 ] ]
  end
end
