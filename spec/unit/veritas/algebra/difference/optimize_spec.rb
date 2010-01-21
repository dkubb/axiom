require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Difference#optimize' do
  before do
    @header = [ [ :id, Integer ] ]
    @left   = Relation.new(@header, [ [ 1 ] ])
    @right  = Relation.new(@header, [ [ 1 ] ])
  end

  subject { @difference.optimize }

  describe 'left is an empty relation' do
    before do
      @left = Relation::Empty.new(@header)

      @difference = Algebra::Difference.new(@left, @right)
    end

    it { should equal(@left) }
  end

  describe 'right is an empty relation' do
    before do
      @right = Relation::Empty.new(@header)

      @difference = Algebra::Difference.new(@left, @right)
    end

    it { should equal(@left) }
  end

  describe 'left is an empty relation when optimized' do
    before do
      @left = Algebra::Restriction.new(@left, Algebra::Restriction::False.new)

      @difference = Algebra::Difference.new(@left, @right)
    end

    it { should be_kind_of(Relation::Empty) }
  end

  describe 'right is an empty relation when optimized' do
    before do
      @right = Algebra::Restriction.new(@right, Algebra::Restriction::False.new)

      @difference = Algebra::Difference.new(@left, @right)
    end

    it { should equal(@left) }
  end

  describe 'left and right are not empty relations' do
    before do
      @difference = Algebra::Difference.new(@left, @right)
    end

    it { should equal(@difference) }
  end
end
