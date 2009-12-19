require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#intersect' do
  before do
    @header = [ [ :id, Integer ] ]

    @other = Relation.new(@header, [ [ 2 ] ])
  end

  subject { Relation.new(@header, [ [ 1 ] ]).intersect(@other) }

  it { should be_kind_of(Algebra::Intersection) }
end
