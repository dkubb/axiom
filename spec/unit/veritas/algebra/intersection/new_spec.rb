require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Intersection.new' do
  before do
    @header = [ [ :id, Integer ] ]

    @left = Relation.new(@header, [ [ 1 ] ])
  end

  subject { Algebra::Intersection.new(@left, @right) }

  describe 'with relations having a similar header' do
    before do
      @right = Relation.new(@header, [ [ 1 ] ])
    end

    it { method(:subject).should_not raise_error }
  end

  describe 'with relations having a different header' do
    before do
      @right = Relation.new([ [ :number, Integer ] ], [ [ 1 ] ])
    end

    it { method(:subject).should raise_error(HeaderMismatchError) }
  end
end
