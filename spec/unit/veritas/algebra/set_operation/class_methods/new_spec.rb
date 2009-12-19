require File.expand_path('../../../../../../spec_helper', __FILE__)
require File.expand_path('../../fixtures/classes', __FILE__)

describe 'Veritas::Algebra::SetOperation.new' do
  before do
    @header = [ [ :id, Integer ] ]

    @left = Relation.new(@header, [ [ 1 ] ])
  end

  subject { SetOperationSpecs::BasicObject.new(@left, @right) }

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

    it { method(:subject).should raise_error(HeaderMismatchError, 'the headers must be equivalent for SetOperationSpecs::BasicObject.new') }
  end
end
