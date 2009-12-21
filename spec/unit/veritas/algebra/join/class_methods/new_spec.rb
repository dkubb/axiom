require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Join.new' do
  before do
    @header = [ [ :id, Integer ] ]

    @left = Relation.new(@header, [ [ 1 ] ])
  end

  subject { Algebra::Join.new(@left, @right) }

  describe 'with relations having similar headers' do
    before do
      @right = Relation.new(@header, [ [ 2 ] ])
    end

    it { method(:subject).should_not raise_error }
  end

  describe 'with relations having different headers' do
    before do
      @right = Relation.new([ [ :number, Integer ] ], [ [ 2 ] ])
    end

    it { method(:subject).should raise_error(InvalidHeaderError, 'the headers must have common attributes for Veritas::Algebra::Join.new') }
  end
end
