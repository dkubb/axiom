require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::GreaterThanOrEqualTo#optimize' do
  before do
    @attribute = Attribute::Integer.new(:id)
  end

  subject { @greater_than_or_equal_to.optimize }

  describe 'left and right are attributes' do
    describe 'and equivalent' do
      before do
        @greater_than_or_equal_to = Algebra::Restriction::GreaterThanOrEqualTo.new(@attribute, @attribute)
      end

      it { should equal(Algebra::Restriction::True.instance) }
    end

    describe 'and are not comparable' do
      before do
        @other = Attribute::Float.new(:float)

        @greater_than_or_equal_to = Algebra::Restriction::GreaterThanOrEqualTo.new(@attribute, @other)
      end

      it { should equal(Algebra::Restriction::False.instance) }
    end

    describe 'and left is always less than right' do
      before do
        @left  = @attribute
        @right = Attribute::Integer.new(:right, :size => 2**31..2**31)

        @greater_than_or_equal_to = Algebra::Restriction::GreaterThanOrEqualTo.new(@left, @right)
      end

      it { should equal(Algebra::Restriction::False.instance) }
    end

    describe 'and left is always greater than right' do
      before do
        @left  = @attribute
        @right = Attribute::Integer.new(:right, :size => -1..-1)

        @greater_than_or_equal_to = Algebra::Restriction::GreaterThanOrEqualTo.new(@left, @right)
      end

      it { should equal(Algebra::Restriction::True.instance) }
    end
  end

  describe 'left is an attribute' do
    describe 'right is a valid value' do
      before do
        @greater_than_or_equal_to = Algebra::Restriction::GreaterThanOrEqualTo.new(@attribute, 1)
      end

      it { should equal(@greater_than_or_equal_to) }
    end

    describe 'right is an invalid primitive' do
      before do
        @greater_than_or_equal_to = Algebra::Restriction::GreaterThanOrEqualTo.new(@attribute, 'a')
      end

      it { should equal(Algebra::Restriction::False.instance) }
    end
  end

  describe 'right is an attribute' do
    describe 'left is a valid value' do
      before do
        @greater_than_or_equal_to = Algebra::Restriction::GreaterThanOrEqualTo.new(1, @attribute)
      end

      it { should eql(Algebra::Restriction::LessThanOrEqualTo.new(@attribute, 1)) }
    end

    describe 'left is an invalid primitive' do
      before do
        @greater_than_or_equal_to = Algebra::Restriction::GreaterThanOrEqualTo.new('a', @attribute)
      end

      it { should equal(Algebra::Restriction::False.instance) }
    end
  end

  describe 'left and right are values' do
    describe 'that will evaluate to true' do
      before do
        @greater_than_or_equal_to = Algebra::Restriction::GreaterThanOrEqualTo.new(1, 1)
      end

      it { should equal(Algebra::Restriction::True.instance) }
    end

    describe 'that will evaluate to false' do
      before do
        @greater_than_or_equal_to = Algebra::Restriction::GreaterThanOrEqualTo.new(1, 2)
      end

      it { should equal(Algebra::Restriction::False.instance) }
    end
  end
end
