require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Predicate::Inequality#optimize' do
  before do
    @attribute = Attribute::Integer.new(:id)
  end

  subject { @inequality.optimize }

  describe 'left and right are attributes' do
    describe 'and equivalent' do
      before do
        @inequality = Logic::Predicate::Inequality.new(@attribute, @attribute)
      end

      it { should equal(Logic::Proposition::False.instance) }
    end

    describe 'and are not joinable' do
      before do
        @other = Attribute::String.new(:other)

        @inequality = Logic::Predicate::Inequality.new(@attribute, @other)
      end

      it { should equal(Logic::Proposition::True.instance) }
    end

    describe 'and are joinable' do
      before do
        @other = Attribute::Numeric.new(:other)

        @inequality = Logic::Predicate::Inequality.new(@attribute, @other)
      end

      it { should equal(@inequality) }
    end
  end

  describe 'left is an attribute' do
    describe 'right is a valid value' do
      before do
        @inequality = Logic::Predicate::Inequality.new(@attribute, 1)
      end

      it { should equal(@inequality) }
    end

    describe 'right is an invalid value' do
      before do
        @inequality = Logic::Predicate::Inequality.new(@attribute, 'a')
      end

      it { should equal(Logic::Proposition::True.instance) }
    end
  end

  describe 'right is an attribute' do
    describe 'left is a valid value' do
      before do
        @inequality = Logic::Predicate::Inequality.new(1, @attribute)
      end

      it { should eql(Logic::Predicate::Inequality.new(@attribute, 1)) }
    end

    describe 'left is an invalid value' do
      before do
        @inequality = Logic::Predicate::Inequality.new('a', @attribute)
      end

      it { should equal(Logic::Proposition::True.instance) }
    end
  end

  describe 'left and right are constants' do
    describe 'that will evaluate to true' do
      before do
        @inequality = Logic::Predicate::Inequality.new(1, 2)
      end

      it { should equal(Logic::Proposition::True.instance) }
    end

    describe 'that will evaluate to false' do
      before do
        @inequality = Logic::Predicate::Inequality.new(1, 1)
      end

      it { should equal(Logic::Proposition::False.instance) }
    end
  end
end
