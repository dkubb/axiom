require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Union#optimize' do
  before do
    @header = [ [ :id, Integer ] ]
    @left   = Relation.new(@header, [ [ 1 ] ])
    @right  = Relation.new(@header, [ [ 1 ] ])

    @left.should_not_receive(:each)
    @right.should_not_receive(:each)
  end

  subject { @union.optimize }

  describe 'left is an empty relation' do
    before do
      @left = Relation::Empty.new(@header)

      @union = Algebra::Union.new(@left, @right)
    end

    it { should equal(@left) }
  end

  describe 'right is an empty relation' do
    before do
      @right = Relation::Empty.new(@header)

      @union = Algebra::Union.new(@left, @right)
    end

    it { should equal(@right) }
  end

  describe 'left is an empty relation when optimized' do
    before do
      @left = Algebra::Restriction.new(@left, Algebra::Restriction::False.new)

      @union = Algebra::Union.new(@left, @right)
    end

    it { should eql(Relation::Empty.new(@header)) }
  end

  describe 'right is an empty relation when optimized' do
    before do
      @right = Algebra::Restriction.new(@right, Algebra::Restriction::False.new)

      @union = Algebra::Union.new(@left, @right)
    end

    it { should eql(Relation::Empty.new(@header)) }
  end

  describe 'left and right are not empty relations' do
    before do
      @union = Algebra::Union.new(@left, @right)
    end

    it { should equal(@union) }
  end
end
