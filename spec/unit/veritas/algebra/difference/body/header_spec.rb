require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Difference::Body#header' do
  before do
    @header = Relation::Header.new([ [ :id, Integer ] ])
    @left   = Relation.new(@header, [ [ 1 ] ])
    @right  = Relation.new(@header, [ [ 2 ] ])

    @body = Algebra::Difference::Body.new(@left, @right)
  end

  subject { @body.header }

  it { should equal(@header) }
end
