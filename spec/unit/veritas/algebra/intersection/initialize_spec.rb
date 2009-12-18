require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Intersection#initialize' do
  before do
    @header = [ [ :id, Integer ] ]
    @body   = [ [ 1 ] ]

    @left  = Relation.new(@header, @body)
    @right = Relation.new(@header, @body)
  end

  subject { Algebra::Intersection.new(@left, @right) }

  it { should be_kind_of(Algebra::Intersection) }
end
