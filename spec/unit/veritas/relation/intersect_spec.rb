require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#intersect' do
  before do
    header = [ [ :id, Integer ] ]

    @relation = Relation.new(header, [ [ 1 ] ])
    @other    = Relation.new(header, [ [ 2 ] ])
  end

  subject { @relation.intersect(@other) }

  it { should be_kind_of(Algebra::Intersection) }

  it 'should behave the same as Array#&' do
    should == (@relation.to_a & @other.to_a)
  end
end

describe 'Veritas::Relation#&' do
  it 'is an alias to #intersect' do
    klass = Relation
    klass.instance_method(:&).should == klass.instance_method(:intersect)
  end
end
