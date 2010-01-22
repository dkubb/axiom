require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::Equality#optimize' do
  before do
    @attribute = Attribute::Integer.new(:id)
  end

  subject { @equality.optimize }

  describe 'left and right are equivalent attributes' do
    before do
      @equality = Algebra::Restriction::Equality.new(@attribute, @attribute)
    end

    it { should be_instance_of(Algebra::Restriction::True) }
  end

  describe 'left is an attribute' do
    before do
      @equality = Algebra::Restriction::Equality.new(@attribute, 1)
    end

    it { should equal(@equality) }
  end

  describe 'right is an attribute' do
    before do
      @equality = Algebra::Restriction::Equality.new(1, @attribute)
    end

    it { should equal(@equality) }
  end

  describe 'left and right are not attributes' do
    before do
      @equality = Algebra::Restriction::Equality.new(1, 1)
    end

    it { should be_instance_of(Algebra::Restriction::True) }
  end
end
