require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#intersection' do
  before do
    header = [ [ :id, Integer ] ]

    @relation = Relation.new(header, [ [ 1 ] ])
    @other    = Relation.new(header, [ [ 2 ] ])
  end

  subject { @relation.intersection(@other) }

  it { should be_kind_of(Algebra::Intersection) }
end
