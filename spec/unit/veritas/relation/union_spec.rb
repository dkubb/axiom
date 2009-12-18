require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#union' do
  before do
    header = [ [ :id, Integer ] ]

    @relation = Relation.new(header, [ [ 1 ] ])
    @other    = Relation.new(header, [ [ 2 ] ])
  end

  subject { @relation.union(@other) }

  it { should be_kind_of(Algebra::Union) }
end

describe 'Veritas::Relation#|' do
  it 'is an alias to #union' do
    Relation.instance_method(:|).should == Relation.instance_method(:union)
  end
end
