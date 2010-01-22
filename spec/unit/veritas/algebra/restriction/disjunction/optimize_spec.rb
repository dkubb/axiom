require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::Disjunction#optimize' do
  before do
    @attribute = Attribute::Integer.new(:id)
  end

  subject { @disjunction.optimize }

  describe 'left and right are predicates' do
    before do
      @left  = @attribute.gt(1)
      @right = @attribute.lt(3)

      @disjunction = Algebra::Restriction::Disjunction.new(@left, @right)
    end

    it { should equal(@disjunction) }
  end

  describe 'left and right are negated predicates' do
    before do
      @disjunction = Algebra::Restriction::Disjunction.new(
        Algebra::Restriction::Negation.new(@attribute.gt(1)),
        Algebra::Restriction::Negation.new(@attribute.lt(3))
      )
    end

    it { should_not equal(@disjunction) }

    it 'should invert the operands' do
      should eql(Algebra::Restriction::Disjunction.new(@attribute.lte(1), @attribute.gte(3)))
    end
  end

  describe 'left and right are the same' do
    before do
      @left  = @attribute.gt(1)
      @right = @attribute.gt(1)

      @disjunction = Algebra::Restriction::Disjunction.new(@left, @right)
    end

    it { should equal(@left) }
  end

  describe 'left and right are true propositions' do
    before do
      @left  = Veritas::Algebra::Restriction::True.new
      @right = Veritas::Algebra::Restriction::True.new

      @disjunction = Algebra::Restriction::Disjunction.new(@left, @right)
    end

    it { should equal(@left) }
  end

  describe 'left and right are false propositions' do
    before do
      @left  = Veritas::Algebra::Restriction::False.new
      @right = Veritas::Algebra::Restriction::False.new

      @disjunction = Algebra::Restriction::Disjunction.new(@left, @right)
    end

    it { should equal(@left) }
  end

  describe 'right is a true proposition' do
    before do
      @left  = @attribute.gt(1)
      @right = Veritas::Algebra::Restriction::True.new

      @disjunction = Algebra::Restriction::Disjunction.new(@left, @right)
    end

    it { should equal(@right) }
  end

  describe 'left is a true proposition' do
    before do
      @left  = Veritas::Algebra::Restriction::True.new
      @right = @attribute.lt(3)

      @disjunction = Algebra::Restriction::Disjunction.new(@left, @right)
    end

    it { should equal(@left) }
  end

  describe 'right is a false proposition' do
    before do
      @left  = @attribute.gt(1)
      @right = Veritas::Algebra::Restriction::False.new

      @disjunction = Algebra::Restriction::Disjunction.new(@left, @right)
    end

    it { should equal(@left) }
  end

  describe 'left is a false proposition' do
    before do
      @left  = Veritas::Algebra::Restriction::False.new
      @right = @attribute.lt(3)

      @disjunction = Algebra::Restriction::Disjunction.new(@left, @right)
    end

    it { should equal(@right) }
  end
end
