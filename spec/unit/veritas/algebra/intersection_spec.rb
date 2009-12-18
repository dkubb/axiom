require File.expand_path('../../../../spec_helper', __FILE__)

include Veritas

describe Algebra::Intersection do
  before do
    @header = [ [ :id, Integer ] ]

    @left  = Relation.new(@header, [ [ 1 ] ])
    @right = Relation.new(@header, [ [ 2 ] ])
  end

  it { Algebra::Intersection.new(@left, @right).should be_kind_of(Relation) }
end
