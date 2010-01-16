require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Product.new' do
  before do
    @header = [ [ :id, Integer ] ]

    @left = Relation.new(@header, [ [ 1 ] ])
  end

  subject { Algebra::Product.new(@left, @right) }

  describe 'with relations having headers with common attributes' do
    before do
      @right = Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 2, 'Dan Kubb' ] ])
    end

    it { method(:subject).should raise_error(InvalidHeaderError, 'the headers must be disjointed for Veritas::Algebra::Product.new') }
  end

  describe 'with relations having equivalent headers' do
    before do
      @right = Relation.new(@header, [ [ 2 ] ])
    end

    it { method(:subject).should raise_error(InvalidHeaderError, 'the headers must be disjointed for Veritas::Algebra::Product.new') }
  end

  describe 'with relations having different headers' do
    before do
      @right = Relation.new([ [ :number, Integer ] ], [ [ 2 ] ])
    end

    it { method(:subject).should_not raise_error }
  end
end
