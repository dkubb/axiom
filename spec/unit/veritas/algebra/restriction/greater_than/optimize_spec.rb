require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::GreaterThan#optimize' do
  before do
    @attribute = Attribute::Integer.new(:id)
  end

  subject { @greater_than.optimize }

  describe 'left and right are equivalent attributes' do
    before do
      @greater_than = Algebra::Restriction::GreaterThan.new(@attribute, @attribute)
    end

    it { should be_instance_of(Algebra::Restriction::False) }
  end

  describe 'left is an attribute' do
    before do
      @greater_than = Algebra::Restriction::GreaterThan.new(@attribute, 1)
    end

    it { should equal(@greater_than) }
  end

  describe 'right is an attribute' do
    before do
      @greater_than = Algebra::Restriction::GreaterThan.new(1, @attribute)
    end

    it { should equal(@greater_than) }
  end

  describe 'left and right are not attributes' do
    before do
      @greater_than = Algebra::Restriction::GreaterThan.new(2, 1)
    end

    it { should be_instance_of(Algebra::Restriction::True) }
  end
end
