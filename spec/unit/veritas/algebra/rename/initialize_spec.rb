require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Rename#initialize' do
  before do
    @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])
  end

  subject { Algebra::Rename.new(@relation, :id => :other_id) }

  it 'should set the relation' do
    subject.relation.should equal(@relation)
  end

  it 'should set the header' do
    subject.header.should == [ [ :other_id, Integer ] ]
  end
end
