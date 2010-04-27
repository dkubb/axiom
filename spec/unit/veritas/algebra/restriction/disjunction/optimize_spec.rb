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

    it 'inverts the operands' do
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
      @left  = Algebra::Restriction::True.instance
      @right = Algebra::Restriction::True.instance

      @disjunction = Algebra::Restriction::Disjunction.new(@left, @right)
    end

    it { should equal(@left) }
  end

  describe 'left and right are false propositions' do
    before do
      @left  = Algebra::Restriction::False.instance
      @right = Algebra::Restriction::False.instance

      @disjunction = Algebra::Restriction::Disjunction.new(@left, @right)
    end

    it { should equal(@left) }
  end

  describe 'right is a true proposition' do
    before do
      @left  = @attribute.gt(1)
      @right = Algebra::Restriction::True.instance

      @disjunction = Algebra::Restriction::Disjunction.new(@left, @right)
    end

    it { should equal(@right) }
  end

  describe 'left is a true proposition' do
    before do
      @left  = Algebra::Restriction::True.instance
      @right = @attribute.lt(3)

      @disjunction = Algebra::Restriction::Disjunction.new(@left, @right)
    end

    it { should equal(@left) }
  end

  describe 'right is a false proposition' do
    before do
      @left  = @attribute.gt(1)
      @right = Algebra::Restriction::False.instance

      @disjunction = Algebra::Restriction::Disjunction.new(@left, @right)
    end

    it { should equal(@left) }
  end

  describe 'left is a false proposition' do
    before do
      @left  = Algebra::Restriction::False.instance
      @right = @attribute.lt(3)

      @disjunction = Algebra::Restriction::Disjunction.new(@left, @right)
    end

    it { should equal(@right) }
  end

  describe 'left and right are equal predicates for the same attribute and different values' do
    before do
      @left  = @attribute.eq(1)
      @right = @attribute.eq(3)

      @disjunction = Algebra::Restriction::Disjunction.new(@left, @right)
    end

    it { should eql(@attribute.in([ 1, 3 ])) }
  end

  describe 'left and right are equal predicates for the same attribute and the same values' do
    before do
      @left  = @attribute.eq(1)
      @right = @attribute.eq(1)

      @disjunction = Algebra::Restriction::Disjunction.new(@left, @right)
    end

    it { should eql(@attribute.eq(1)) }
  end

  describe 'left and right are equal predicates for the same attribute, but left.right is an attribute' do
    before do
      @other = Attribute::Integer.new(:other_id)

      @left  = @attribute.eq(@other)
      @right = @attribute.eq(1)

      @disjunction = Algebra::Restriction::Disjunction.new(@left, @right)
    end

    it { should eql(@left | @right) }
  end

  describe 'left and right are equal predicates for the same attribute, but right.right is an attribute' do
    before do
      @other = Attribute::Integer.new(:other_id)

      @left  = @attribute.eq(1)
      @right = @attribute.eq(@other)

      @disjunction = Algebra::Restriction::Disjunction.new(@left, @right)
    end

    it { should eql(@left | @right) }
  end
end
