require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::LessThan#optimize' do
  before do
    @attribute = Attribute::Integer.new(:id)
  end

  subject { @less_than.optimize }

  describe 'left and right are equivalent attributes' do
    before do
      @less_than = Algebra::Restriction::LessThan.new(@attribute, @attribute)
    end

    it 'should always be false' do
      should be_kind_of(Algebra::Restriction::False)
    end
  end

  describe 'left is an attribute' do
    before do
      @less_than = Algebra::Restriction::LessThan.new(@attribute, 1)
    end

    it 'should equal the predicate' do
      should equal(@less_than)
    end
  end

  describe 'right is an attribute' do
    before do
      @less_than = Algebra::Restriction::LessThan.new(1, @attribute)
    end

    it 'should equal the predicate' do
      should equal(@less_than)
    end
  end

  describe 'left and right are not attributes' do
    before do
      @less_than = Algebra::Restriction::LessThan.new(1, 2)
    end

    it 'should evaluate the proposition' do
      should eql(Algebra::Restriction::True.new)
    end
  end
end
