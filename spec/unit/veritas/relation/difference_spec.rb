require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#difference' do
  before do
    header = [ [ :id, Integer ] ]

    @relation = Relation.new(header, [ [ 1 ] ])
    @other    = Relation.new(header, [ [ 2 ] ])
  end

  subject { @relation.difference(@other) }

  it { should be_kind_of(Algebra::Difference) }
end

describe 'Veritas::Relation#-' do
  it 'is an alias to #difference' do
    klass = Relation
    klass.instance_method(:-).should == klass.instance_method(:difference)
  end
end
