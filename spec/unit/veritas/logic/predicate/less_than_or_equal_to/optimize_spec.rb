require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Predicate::LessThanOrEqualTo#optimize' do
  before do
    @attribute = Attribute::Integer.new(:id)
  end

  subject { @less_than_or_equal_to.optimize }

  describe 'left and right are attributes' do
    describe 'and equivalent' do
      before do
        @less_than_or_equal_to = Logic::Predicate::LessThanOrEqualTo.new(@attribute, @attribute)
      end

      it { should equal(Logic::Proposition::True.instance) }
    end

    describe 'and are not comparable' do
      before do
        @other = Attribute::Float.new(:float)

        @less_than_or_equal_to = Logic::Predicate::LessThanOrEqualTo.new(@attribute, @other)
      end

      it { should equal(Logic::Proposition::False.instance) }
    end

    describe 'and left is always less than right' do
      before do
        @left  = @attribute
        @right = Attribute::Integer.new(:right, :size => 2**31..2**31)

        @less_than_or_equal_to = Logic::Predicate::LessThanOrEqualTo.new(@left, @right)
      end

      it { should equal(Logic::Proposition::True.instance) }
    end

    describe 'and left is always greater than right' do
      before do
        @left  = @attribute
        @right = Attribute::Integer.new(:right, :size => -1..-1)

        @less_than_or_equal_to = Logic::Predicate::LessThanOrEqualTo.new(@left, @right)
      end

      it { should equal(Logic::Proposition::False.instance) }
    end
  end

  describe 'left is an attribute' do
    describe 'right is a valid value' do
      before do
        @less_than_or_equal_to = Logic::Predicate::LessThanOrEqualTo.new(@attribute, 1)
      end

      it { should equal(@less_than_or_equal_to) }
    end

    describe 'right is an invalid primitive' do
      before do
        @less_than_or_equal_to = Logic::Predicate::LessThanOrEqualTo.new(@attribute, 'a')
      end

      it { should equal(Logic::Proposition::False.instance) }
    end
  end

  describe 'right is an attribute' do
    describe 'left is a valid value' do
      before do
        @less_than_or_equal_to = Logic::Predicate::LessThanOrEqualTo.new(1, @attribute)
      end

      it { should eql(Logic::Predicate::GreaterThanOrEqualTo.new(@attribute, 1)) }
    end

    describe 'left is an invalid primitive' do
      before do
        @less_than_or_equal_to = Logic::Predicate::LessThanOrEqualTo.new('a', @attribute)
      end

      it { should equal(Logic::Proposition::False.instance) }
    end
  end

  describe 'left and right are values' do
    describe 'that will evaluate to true' do
      before do
        @less_than_or_equal_to = Logic::Predicate::LessThanOrEqualTo.new(1, 1)
      end

      it { should equal(Logic::Proposition::True.instance) }
    end

    describe 'that will evaluate to false' do
      before do
        @less_than_or_equal_to = Logic::Predicate::LessThanOrEqualTo.new(2, 1)
      end

      it { should equal(Logic::Proposition::False.instance) }
    end
  end
end
