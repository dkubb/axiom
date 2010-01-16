require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Join.new' do
  before do
    @header = [ [ :id, Integer ] ]

    @left = Relation.new(@header, [ [ 1 ], [ 2 ] ])
  end

  subject { Algebra::Join.new(@left, @right) }

  describe 'with relations having headers with common attributes' do
    before do
      @right = Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 2, 'Dan Kubb' ] ])
    end

    it { method(:subject).should_not raise_error }
  end

  describe 'with relations having similar headers' do
    before do
      @right = @left.dup
    end

    it { method(:subject).should raise_error(InvalidHeaderError, 'the headers are identical, use intersection instead') }
  end

  describe 'with relations having different headers' do
    before do
      @right = Relation.new([ [ :name, String ] ], [ [ 'Dan Kubb' ] ])
    end

    it { method(:subject).should raise_error(InvalidHeaderError, 'the headers must have common attributes for Veritas::Algebra::Join.new') }
  end
end
