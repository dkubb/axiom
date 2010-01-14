require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Intersection#each' do
  before do
    @header = [ [ :id, Integer ] ]

    @left = Relation.new(@header, [ [ 1 ] ])

    @yield = []
  end

  subject { @intersection.each { |tuple| @yield << tuple } }

  describe 'with relations having similar bodies' do
    before do
      @intersection = Algebra::Intersection.new(@left, @left.dup)
    end

    it { should equal(@intersection) }

    it 'should yield the intersection' do
      method(:subject).should change { @yield.dup }.from([]).to([ [ 1 ] ])
    end
  end

  describe 'with relations having different bodies' do
    before do
      @right = Relation.new(@header, [ [ 2 ] ])

      @intersection = Algebra::Intersection.new(@left, @right)
    end

    it { should equal(@intersection) }

    it 'should yield the intersection' do
      method(:subject).should_not change { @yield.dup }
    end
  end
end
