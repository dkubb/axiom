require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#join' do
  before do
    @relation = Relation.new([ [ :id, Integer ], [ :name, String  ] ], [ [ 1, 'Dan Kubb' ] ])
    @other    = Relation.new([ [ :id, Integer ], [ :age,  Integer ] ], [ [ 1, 34         ] ])
  end

  subject { @relation.join(@other) }

  it { should be_kind_of(Algebra::Join) }
end

describe 'Veritas::Relation#+' do
  it 'is an alias to #join' do
    Relation.instance_method(:+).should == Relation.instance_method(:join)
  end
end
