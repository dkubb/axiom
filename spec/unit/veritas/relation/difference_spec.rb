require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#difference' do
  before do
    @header = [ [ :id, Integer ] ]

    @other = Relation.new(@header, [ [ 2 ] ])
  end

  subject { Relation.new(@header, [ [ 1 ] ]).difference(@other) }

  it { should be_kind_of(Algebra::Difference) }
end
