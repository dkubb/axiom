require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::Inequality#optimize' do
  before do
    @attribute = Attribute::Integer.new(:id)
  end

  subject { @inequality.optimize }

  describe 'left and right are equivalent attributes' do
    before do
      @inequality = Algebra::Restriction::Inequality.new(@attribute, @attribute)
    end

    it { should == Algebra::Restriction::False.instance }
  end

  describe 'left is an attribute' do
    before do
      @inequality = Algebra::Restriction::Inequality.new(@attribute, 1)
    end

    it { should equal(@inequality) }
  end

  describe 'right is an attribute' do
    before do
      @inequality = Algebra::Restriction::Inequality.new(1, @attribute)
    end

    it { should equal(@inequality) }
  end

  describe 'left and right are not attributes' do
    before do
      @inequality = Algebra::Restriction::Inequality.new(1, 2)
    end

    it { should == Algebra::Restriction::True.instance }
  end
end
