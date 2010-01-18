require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#union' do
  before do
    header = [ [ :id, Integer ] ]

    @relation = Relation.new(header, [ [ 1 ] ])
    @other    = Relation.new(header, [ [ 2 ] ])
  end

  subject { @relation.union(@other) }

  it { should be_kind_of(Algebra::Union) }

  it 'should behave the same as Array#|' do
    should == (@relation.to_a | @other.to_a)
  end
end

describe 'Veritas::Relation#|' do
  it 'is an alias to #union' do
    klass = Relation
    klass.instance_method(:|).should == klass.instance_method(:union)
  end
end
