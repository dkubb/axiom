require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::Inequality#optimize' do
  before do
    @attribute = Attribute::Integer.new(:id)
  end

  subject { @inequality.optimize }

  describe 'left and right are attributes' do
    describe 'and equivalent' do
      before do
        @inequality = Algebra::Restriction::Inequality.new(@attribute, @attribute)
      end

      it { should equal(Algebra::Restriction::False.instance) }
    end

    describe 'and are not joinable' do
      before do
        @other = Attribute::String.new(:other)

        @inequality = Algebra::Restriction::Inequality.new(@attribute, @other)
      end

      it { should equal(Algebra::Restriction::True.instance) }
    end

    describe 'and are joinable' do
      before do
        @other = Attribute::Numeric.new(:other)

        @inequality = Algebra::Restriction::Inequality.new(@attribute, @other)
      end

      it { should equal(@inequality) }
    end
  end

  describe 'left is an attribute' do
    describe 'right is a valid value' do
      before do
        @inequality = Algebra::Restriction::Inequality.new(@attribute, 1)
      end

      it { should equal(@inequality) }
    end

    describe 'right is an invalid value' do
      before do
        @inequality = Algebra::Restriction::Inequality.new(@attribute, 'a')
      end

      it { should equal(Algebra::Restriction::True.instance) }
    end
  end

  describe 'right is an attribute' do
    describe 'left is a valid value' do
      before do
        @inequality = Algebra::Restriction::Inequality.new(1, @attribute)
      end

      it { should eql(Algebra::Restriction::Inequality.new(@attribute, 1)) }
    end

    describe 'left is an invalid value' do
      before do
        @inequality = Algebra::Restriction::Inequality.new('a', @attribute)
      end

      it { should equal(Algebra::Restriction::True.instance) }
    end
  end

  describe 'left and right are values' do
    describe 'that will evaluate to true' do
      before do
        @inequality = Algebra::Restriction::Inequality.new(1, 2)
      end

      it { should equal(Algebra::Restriction::True.instance) }
    end

    describe 'that will evaluate to false' do
      before do
        @inequality = Algebra::Restriction::Inequality.new(1, 1)
      end

      it { should equal(Algebra::Restriction::False.instance) }
    end
  end
end
