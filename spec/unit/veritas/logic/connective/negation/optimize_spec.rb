require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Connective::Negation#optimize' do
  before do
    @attribute = Attribute::Integer.new(:id)
  end

  subject { @negation.optimize }

  describe 'operand is a predicate' do
    before do
      @operand = @attribute.gt(1)

      @negation = Logic::Connective::Negation.new(@operand)
    end

    it { should eql(@attribute.lte(1)) }
  end

  describe 'operand is a negated predicate' do
    before do
      @predicate = @attribute.gt(1)
      @operand   = Logic::Connective::Negation.new(@predicate)

      @negation = Logic::Connective::Negation.new(@operand)
    end

    it { should eql(@predicate) }
  end

  describe 'operand is a true proposition' do
    before do
      @operand = Logic::Proposition::True.instance

      @negation = Logic::Connective::Negation.new(@operand)
    end

    it { should equal(Logic::Proposition::False.instance) }
  end

  describe 'operand is a false proposition' do
    before do
      @operand = Logic::Proposition::False.instance

      @negation = Logic::Connective::Negation.new(@operand)
    end

    it { should equal(Logic::Proposition::True.instance) }
  end
end
