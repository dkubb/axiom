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

    it 'should always be true' do
      should be_kind_of(Algebra::Restriction::True)
    end
  end

  describe 'left is an attribute' do
    before do
      @equality = Algebra::Restriction::Equality.new(@attribute, 1)
    end

    it 'should equal the predicate' do
      should equal(@equality)
    end
  end

  describe 'right is an attribute' do
    before do
      @equality = Algebra::Restriction::Equality.new(1, @attribute)
    end

    it 'should equal the predicate' do
      should equal(@equality)
    end
  end

  describe 'left and right are not attributes' do
    before do
      @equality = Algebra::Restriction::Equality.new(1, 1)
    end

    it 'should evaluate the proposition' do
      should eql(Algebra::Restriction::True.new)
    end
  end
end
