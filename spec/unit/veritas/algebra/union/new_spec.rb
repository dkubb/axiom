require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Union.new' do
  before do
    @header = [ [ :id, Integer ] ]

    @left = Relation.new(@header, [ [ 1 ] ])
  end

  subject { Algebra::Union.new(@left, @right) }

  describe 'with relations having a similar header' do
    before do
      @right = Relation.new(@header, [ [ 2 ] ])
    end

    it { method(:subject).should_not raise_error }
  end

  describe 'with relations having a different header' do
    before do
      @right = Relation.new([ [ :number, Integer ] ], [ [ 2 ] ])
    end

    it { method(:subject).should raise_error(HeaderMismatchError) }
  end
end
