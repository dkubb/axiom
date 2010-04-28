require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Connective::Conjunction#optimize' do
  before do
    @attribute = Attribute::Integer.new(:id)
  end

  subject { @conjunction.optimize }

  describe 'left and right are predicates' do
    before do
      @left  = @attribute.gt(1)
      @right = @attribute.lt(3)

      @conjunction = Logic::Connective::Conjunction.new(@left, @right)
    end

    it { should equal(@conjunction) }
  end

  describe 'left and right are negated predicates' do
    before do
      @conjunction = Logic::Connective::Conjunction.new(
        Logic::Connective::Negation.new(@attribute.gt(1)),
        Logic::Connective::Negation.new(@attribute.lt(3))
      )
    end

    it { should_not equal(@conjunction) }

    it 'inverts the operands' do
      should eql(Logic::Connective::Conjunction.new(@attribute.lte(1), @attribute.gte(3)))
    end
  end

  describe 'left and right are the same' do
    before do
      @left  = @attribute.gt(1)
      @right = @attribute.gt(1)

      @conjunction = Logic::Connective::Conjunction.new(@left, @right)
    end

    it { should eql(@left) }
  end

  describe 'left and right are true propositions' do
    before do
      @left  = Logic::Proposition::True.instance
      @right = Logic::Proposition::True.instance

      @conjunction = Logic::Connective::Conjunction.new(@left, @right)
    end

    it { should equal(Logic::Proposition::True.instance) }
  end

  describe 'left and right are false propositions' do
    before do
      @left  = Logic::Proposition::False.instance
      @right = Logic::Proposition::False.instance

      @conjunction = Logic::Connective::Conjunction.new(@left, @right)
    end

    it { should equal(Logic::Proposition::False.instance) }
  end

  describe 'right is a true proposition' do
    before do
      @left  = @attribute.gt(1)
      @right = Logic::Proposition::True.instance

      @conjunction = Logic::Connective::Conjunction.new(@left, @right)
    end

    it { should equal(@left) }
  end

  describe 'left is a true proposition' do
    before do
      @left  = Logic::Proposition::True.instance
      @right = @attribute.lt(3)

      @conjunction = Logic::Connective::Conjunction.new(@left, @right)
    end

    it { should equal(@right) }
  end

  describe 'right is a false proposition' do
    before do
      @left  = @attribute.gt(1)
      @right = Logic::Proposition::False.instance

      @conjunction = Logic::Connective::Conjunction.new(@left, @right)
    end

    it { should equal(Logic::Proposition::False.instance) }
  end

  describe 'left is a false proposition' do
    before do
      @left  = Logic::Proposition::False.instance
      @right = @attribute.lt(3)

      @conjunction = Logic::Connective::Conjunction.new(@left, @right)
    end

    it { should equal(Logic::Proposition::False.instance) }
  end
end
