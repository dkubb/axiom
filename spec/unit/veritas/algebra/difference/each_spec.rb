require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Difference#each' do
  before do
    @header = [ [ :id, Integer ] ]

    @left = Relation.new(@header, [ [ 1 ] ])

    @yield = []
  end

  subject { @difference.each { |tuple| @yield << tuple } }

  describe 'with relations having similar bodies' do
    before do
      @difference = Algebra::Difference.new(@left, @left.dup)
    end

    it { should equal(@difference) }

    it 'should yield the difference' do
      method(:subject).should_not change { @yield.dup }
    end
  end

  describe 'with relations having different bodies' do
    before do
      @right = Relation.new(@header, [ [ 2 ] ])

      @difference = Algebra::Difference.new(@left, @right)
    end

    it { should equal(@difference) }

    it 'should yield the difference' do
      method(:subject).should change { @yield.dup }.from([]).to([ [ 1 ] ])
    end
  end
end
