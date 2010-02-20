require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::LessThan#optimize' do
  before do
    @attribute = Attribute::Integer.new(:id)
  end

  subject { @less_than.optimize }

  describe 'left and right are attributes' do
    describe 'and equivalent' do
      before do
        @less_than = Algebra::Restriction::LessThan.new(@attribute, @attribute)
      end

      it { should == Algebra::Restriction::False.instance }
    end

    describe 'and are not comparable' do
      before do
        @other = Attribute::Float.new(:float)

        @less_than = Algebra::Restriction::LessThan.new(@attribute, @other)
      end

      it { should == Algebra::Restriction::False.instance }
    end

    describe 'and left is always less than right' do
      before do
        @left  = @attribute
        @right = Attribute::Integer.new(:right, :size => 2**31..2**31)

        @less_than = Algebra::Restriction::LessThan.new(@left, @right)
      end

      it { should == Algebra::Restriction::True.instance }
    end

    describe 'and left is always greater than or equal to right' do
      before do
        @left  = @attribute
        @right = Attribute::Integer.new(:right, :size => 0..0)

        @less_than = Algebra::Restriction::LessThan.new(@left, @right)
      end

      it { should == Algebra::Restriction::False.instance }
    end
  end

  describe 'left is an attribute' do
    describe 'right is a valid value' do
      before do
        @less_than = Algebra::Restriction::LessThan.new(@attribute, 1)
      end

      it { should equal(@less_than) }
    end

    describe 'right is an invalid primitive' do
      before do
        @less_than = Algebra::Restriction::LessThan.new(@attribute, 'a')
      end

      it { should == Algebra::Restriction::False.instance }
    end
  end

  describe 'right is an attribute' do
    describe 'left is a valid value' do
      before do
        @less_than = Algebra::Restriction::LessThan.new(1, @attribute)
      end

      it { should equal(@less_than) }
    end

    describe 'left is an invalid primitive' do
      before do
        @less_than = Algebra::Restriction::LessThan.new('a', @attribute)
      end

      it { should == Algebra::Restriction::False.instance }
    end
  end

  describe 'left and right are values' do
    describe 'that will evaluate to true' do
      before do
        @less_than = Algebra::Restriction::LessThan.new(1, 2)
      end

      it { should == Algebra::Restriction::True.instance }
    end

    describe 'that will evaluate to false' do
      before do
        @less_than = Algebra::Restriction::LessThan.new(1, 1)
      end

      it { should == Algebra::Restriction::False.instance }
    end
  end
end
