require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#product' do
  before do
    @relation = Relation.new([ [ :id,   Integer ] ], [ [ 1         ] ])
    @other    = Relation.new([ [ :name, String  ] ], [ [ 'Dan Kub' ] ])
  end

  subject { @relation.product(@other) }

  it { should be_kind_of(Algebra::Product) }
end

describe 'Veritas::Relation#*' do
  it 'is an alias to #product' do
    klass = Relation
    klass.instance_method(:*).should == klass.instance_method(:product)
  end
end
