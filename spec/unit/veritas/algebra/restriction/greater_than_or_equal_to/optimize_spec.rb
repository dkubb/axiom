require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::GreaterThanOrEqualTo#optimize' do
  before do
    @attribute = Attribute::Integer.new(:id)
  end

  subject { @greater_than_or_equal_to.optimize }

  describe 'left and right are equivalent attributes' do
    before do
      @greater_than_or_equal_to = Algebra::Restriction::GreaterThanOrEqualTo.new(@attribute, @attribute)
    end

    it { should == Algebra::Restriction::True.instance }
  end

  describe 'left is an attribute' do
    before do
      @greater_than_or_equal_to = Algebra::Restriction::GreaterThanOrEqualTo.new(@attribute, 1)
    end

    it { should equal(@greater_than_or_equal_to) }
  end

  describe 'right is an attribute' do
    before do
      @greater_than_or_equal_to = Algebra::Restriction::GreaterThanOrEqualTo.new(1, @attribute)
    end

    it { should equal(@greater_than_or_equal_to) }
  end

  describe 'left and right are not attributes' do
    before do
      @greater_than_or_equal_to = Algebra::Restriction::GreaterThanOrEqualTo.new(2, 1)
    end

    it { should == Algebra::Restriction::True.instance }
  end
end
