require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Product#header' do
  before do
    @relation   = Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])
    @attributes = [ :id ]

    @projection = Algebra::Projection.new(@relation, @attributes)
  end

  subject { @projection.header }

  it { should be_kind_of(Relation::Header) }

  it { should ==  [ [ :id, Integer ] ] }
end
