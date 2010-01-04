require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction#initialize' do
  before do
    @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])
    @block    = lambda {}
  end

  subject { Algebra::Restriction.new(@relation, &@block) }

  it 'should set the relation' do
    subject.relation.should equal(@relation)
  end

  it 'should set the block' do
    subject.block.should equal(@block)
  end
end
