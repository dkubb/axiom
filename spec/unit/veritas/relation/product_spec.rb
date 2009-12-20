require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#product' do
  before do
    @header = [ [ :name, String ] ]

    @other = Relation.new(@header, [ [ 'Dan Kub' ] ])
  end

  subject { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]).product(@other) }

  it { should be_kind_of(Algebra::Product) }
end

describe 'Veritas::Relation#*' do
  it 'is an alias to #product' do
    Relation.instance_method(:*).should == Relation.instance_method(:product)
  end
end
