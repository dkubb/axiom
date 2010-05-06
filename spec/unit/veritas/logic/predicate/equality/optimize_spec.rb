require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Predicate::Equality#optimize' do
  let(:attribute) { Attribute::Integer.new(:id) }

  subject { equality.optimize }

  describe 'left and right are attributes' do
    describe 'and equivalent' do
      let(:equality) { Logic::Predicate::Equality.new(attribute, attribute) }

      it { should equal(Logic::Proposition::True.instance) }
    end

    describe 'and are not joinable' do
      let(:other)    { Attribute::String.new(:other)                    }
      let(:equality) { Logic::Predicate::Equality.new(attribute, other) }

      it { should equal(Logic::Proposition::False.instance) }
    end

    describe 'and are joinable' do
      let(:other)    { Attribute::Numeric.new(:other)                   }
      let(:equality) { Logic::Predicate::Equality.new(attribute, other) }

      it { should equal(equality) }
    end
  end

  describe 'left is an attribute' do
    describe 'right is a valid value' do
      let(:equality) { Logic::Predicate::Equality.new(attribute, 1) }

      it { should equal(equality) }
    end

    describe 'right is an invalid value' do
      let(:equality) { Logic::Predicate::Equality.new(attribute, 'a') }

      it { should equal(Logic::Proposition::False.instance) }
    end
  end

  describe 'right is an attribute' do
    describe 'left is a valid value' do
      let(:equality) { Logic::Predicate::Equality.new(1, attribute) }

      it { should eql(Logic::Predicate::Equality.new(attribute, 1)) }
    end

    describe 'left is an invalid value' do
      let(:equality) { Logic::Predicate::Equality.new('a', attribute) }

      it { should equal(Logic::Proposition::False.instance) }
    end
  end

  describe 'left and right are constants' do
    describe 'that will evaluate to true' do
      let(:equality) { Logic::Predicate::Equality.new(1, 1) }

      it { should equal(Logic::Proposition::True.instance) }
    end

    describe 'that will evaluate to false' do
      let(:equality) { Logic::Predicate::Equality.new(1, 2) }

      it { should equal(Logic::Proposition::False.instance) }
    end
  end
end
