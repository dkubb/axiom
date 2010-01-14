require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Union#each' do
  before do
    @header = [ [ :id, Integer ] ]

    @left = Relation.new(@header, [ [ 1 ] ])

    @yield = []
  end

  subject { @union.each { |tuple| @yield << tuple } }

  describe 'with relations having similar bodies' do
    before do
      @union = Algebra::Union.new(@left, @left.dup)
    end

    it { should equal(@union) }

    it 'should yield the union' do
      method(:subject).should change { @yield.dup }.from([]).to([ [ 1 ] ])
    end
  end

  describe 'with relations having different bodies' do
    before do
      @right = Relation.new(@header, [ [ 2 ] ])

      @union = Algebra::Union.new(@left, @right)
    end

    it { should equal(@union) }

    it 'should yield the union' do
      method(:subject).should change { @yield.dup }.from([]).to([ [ 1 ], [ 2 ] ])
    end
  end
end
