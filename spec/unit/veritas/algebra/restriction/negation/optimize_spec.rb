require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::Negation#optimize' do
  before do
    @attribute = Attribute::Integer.new(:id)
  end

  subject { @negation.optimize }

  describe 'operand is a predicate' do
    before do
      @operand = @attribute.gt(1)

      @negation = Algebra::Restriction::Negation.new(@operand)
    end

    it { should eql(@attribute.lte(1)) }
  end

  describe 'operand is a negated predicate' do
    before do
      @predicate = @attribute.gt(1)
      @operand   = Algebra::Restriction::Negation.new(@predicate)

      @negation = Algebra::Restriction::Negation.new(@operand)
    end

    it { should eql(@predicate) }
  end

  describe 'operand is a true proposition' do
    before do
      @operand = Algebra::Restriction::True.instance

      @negation = Algebra::Restriction::Negation.new(@operand)
    end

    it { should equal(Algebra::Restriction::False.instance) }
  end

  describe 'operand is a false proposition' do
    before do
      @operand = Algebra::Restriction::False.instance

      @negation = Algebra::Restriction::Negation.new(@operand)
    end

    it { should equal(Algebra::Restriction::True.instance) }
  end
end
