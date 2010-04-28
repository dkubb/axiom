require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Predicate::GreaterThan#optimize' do
  before do
    @attribute = Attribute::Integer.new(:id)
  end

  subject { @greater_than.optimize }

  describe 'left and right are attributes' do
    describe 'and equivalent' do
      before do
        @greater_than = Logic::Predicate::GreaterThan.new(@attribute, @attribute)
      end

      it { should equal(Logic::Proposition::False.instance) }
    end

    describe 'and are not comparable' do
      before do
        @other = Attribute::Float.new(:float)

        @greater_than = Logic::Predicate::GreaterThan.new(@attribute, @other)
      end

      it { should equal(Logic::Proposition::False.instance) }
    end

    describe 'and left is always less than or equal to right' do
      before do
        @left  = @attribute
        @right = Attribute::Integer.new(:right, :size => 2**31-1..2**31-1)

        @greater_than = Logic::Predicate::GreaterThan.new(@left, @right)
      end

      it { should equal(Logic::Proposition::False.instance) }
    end

    describe 'and left is always greater than right' do
      before do
        @left  = @attribute
        @right = Attribute::Integer.new(:right, :size => -1..-1)

        @greater_than = Logic::Predicate::GreaterThan.new(@left, @right)
      end

      it { should equal(Logic::Proposition::True.instance) }
    end
  end

  describe 'left is an attribute' do
    describe 'right is a valid value' do
      before do
        @greater_than = Logic::Predicate::GreaterThan.new(@attribute, 1)
      end

      it { should equal(@greater_than) }
    end

    describe 'right is an invalid primitive' do
      before do
        @greater_than = Logic::Predicate::GreaterThan.new(@attribute, 'a')
      end

      it { should equal(Logic::Proposition::False.instance) }
    end
  end

  describe 'right is an attribute' do
    describe 'left is a valid value' do
      before do
        @greater_than = Logic::Predicate::GreaterThan.new(1, @attribute)
      end

      it { should eql(Logic::Predicate::LessThan.new(@attribute, 1)) }
    end

    describe 'left is an invalid primitive' do
      before do
        @greater_than = Logic::Predicate::GreaterThan.new('a', @attribute)
      end

      it { should equal(Logic::Proposition::False.instance) }
    end
  end

  describe 'left and right are values' do
    describe 'that will evaluate to true' do
      before do
        @greater_than = Logic::Predicate::GreaterThan.new(2, 1)
      end

      it { should equal(Logic::Proposition::True.instance) }
    end

    describe 'that will evaluate to false' do
      before do
        @greater_than = Logic::Predicate::GreaterThan.new(1, 2)
      end

      it { should equal(Logic::Proposition::False.instance) }
    end
  end
end
