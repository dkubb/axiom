require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Connective::Disjunction#optimize' do
  before do
    @attribute = Attribute::Integer.new(:id)
  end

  subject { @disjunction.optimize }

  describe 'left and right are predicates' do
    before do
      @left  = @attribute.gt(1)
      @right = @attribute.lt(3)

      @disjunction = Logic::Connective::Disjunction.new(@left, @right)
    end

    it { should equal(@disjunction) }
  end

  describe 'left and right are negated predicates' do
    before do
      @disjunction = Logic::Connective::Disjunction.new(
        Logic::Connective::Negation.new(@attribute.gt(1)),
        Logic::Connective::Negation.new(@attribute.lt(3))
      )
    end

    it { should_not equal(@disjunction) }

    it 'inverts the operands' do
      should eql(Logic::Connective::Disjunction.new(@attribute.lte(1), @attribute.gte(3)))
    end
  end

  describe 'left and right are the same' do
    before do
      @left  = @attribute.gt(1)
      @right = @attribute.gt(1)

      @disjunction = Logic::Connective::Disjunction.new(@left, @right)
    end

    it { should equal(@left) }
  end

  describe 'left and right are true propositions' do
    before do
      @left  = Logic::Proposition::True.instance
      @right = Logic::Proposition::True.instance

      @disjunction = Logic::Connective::Disjunction.new(@left, @right)
    end

    it { should equal(@left) }
  end

  describe 'left and right are false propositions' do
    before do
      @left  = Logic::Proposition::False.instance
      @right = Logic::Proposition::False.instance

      @disjunction = Logic::Connective::Disjunction.new(@left, @right)
    end

    it { should equal(@left) }
  end

  describe 'right is a true proposition' do
    before do
      @left  = @attribute.gt(1)
      @right = Logic::Proposition::True.instance

      @disjunction = Logic::Connective::Disjunction.new(@left, @right)
    end

    it { should equal(@right) }
  end

  describe 'left is a true proposition' do
    before do
      @left  = Logic::Proposition::True.instance
      @right = @attribute.lt(3)

      @disjunction = Logic::Connective::Disjunction.new(@left, @right)
    end

    it { should equal(@left) }
  end

  describe 'right is a false proposition' do
    before do
      @left  = @attribute.gt(1)
      @right = Logic::Proposition::False.instance

      @disjunction = Logic::Connective::Disjunction.new(@left, @right)
    end

    it { should equal(@left) }
  end

  describe 'left is a false proposition' do
    before do
      @left  = Logic::Proposition::False.instance
      @right = @attribute.lt(3)

      @disjunction = Logic::Connective::Disjunction.new(@left, @right)
    end

    it { should equal(@right) }
  end

  describe 'left and right are equal predicates for the same attribute and different values' do
    before do
      @left  = @attribute.eq(1)
      @right = @attribute.eq(3)

      @disjunction = Logic::Connective::Disjunction.new(@left, @right)
    end

    it { should eql(@attribute.in([ 1, 3 ])) }
  end

  describe 'left and right are equal predicates for the same attribute and the same values' do
    before do
      @left  = @attribute.eq(1)
      @right = @attribute.eq(1)

      @disjunction = Logic::Connective::Disjunction.new(@left, @right)
    end

    it { should eql(@attribute.eq(1)) }
  end

  describe 'left and right are equal predicates for the same attribute, but left.right is an attribute' do
    before do
      @other = Attribute::Integer.new(:other_id)

      @left  = @attribute.eq(@other)
      @right = @attribute.eq(1)

      @disjunction = Logic::Connective::Disjunction.new(@left, @right)
    end

    it { should eql(@left | @right) }
  end

  describe 'left and right are equal predicates for the same attribute, but right.right is an attribute' do
    before do
      @other = Attribute::Integer.new(:other_id)

      @left  = @attribute.eq(1)
      @right = @attribute.eq(@other)

      @disjunction = Logic::Connective::Disjunction.new(@left, @right)
    end

    it { should eql(@left | @right) }
  end
end
