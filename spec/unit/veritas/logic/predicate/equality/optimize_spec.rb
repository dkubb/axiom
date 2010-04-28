require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Predicate::Equality#optimize' do
  before do
    @attribute = Attribute::Integer.new(:id)
  end

  subject { @equality.optimize }

  describe 'left and right are attributes' do
    describe 'and equivalent' do
      before do
        @equality = Logic::Predicate::Equality.new(@attribute, @attribute)
      end

      it { should equal(Logic::Proposition::True.instance) }
    end

    describe 'and are not joinable' do
      before do
        @other    = Attribute::String.new(:other)
        @equality = Logic::Predicate::Equality.new(@attribute, @other)
      end

      it { should equal(Logic::Proposition::False.instance) }
    end

    describe 'and are joinable' do
      before do
        @other = Attribute::Numeric.new(:other)

        @equality = Logic::Predicate::Equality.new(@attribute, @other)
      end

      it { should equal(@equality) }
    end
  end

  describe 'left is an attribute' do
    describe 'right is a valid value' do
      before do
        @equality = Logic::Predicate::Equality.new(@attribute, 1)
      end

      it { should equal(@equality) }
    end

    describe 'right is an invalid value' do
      before do
        @equality = Logic::Predicate::Equality.new(@attribute, 'a')
      end

      it { should equal(Logic::Proposition::False.instance) }
    end
  end

  describe 'right is an attribute' do
    describe 'left is a valid value' do
      before do
        @equality = Logic::Predicate::Equality.new(1, @attribute)
      end

      it { should eql(Logic::Predicate::Equality.new(@attribute, 1)) }
    end

    describe 'left is an invalid value' do
      before do
        @equality = Logic::Predicate::Equality.new('a', @attribute)
      end

      it { should equal(Logic::Proposition::False.instance) }
    end
  end

  describe 'left and right are not attributes' do
    describe 'that will evaluate to true' do
      before do
        @equality = Logic::Predicate::Equality.new(1, 1)
      end

      it { should equal(Logic::Proposition::True.instance) }
    end

    describe 'that will evaluate to false' do
      before do
        @equality = Logic::Predicate::Equality.new(1, 2)
      end

      it { should equal(Logic::Proposition::False.instance) }
    end
  end
end
