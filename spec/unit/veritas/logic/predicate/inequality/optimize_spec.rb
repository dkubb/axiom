require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Predicate::Inequality#optimize' do
  let(:attribute) { Attribute::Integer.new(:id) }

  subject { inequality.optimize }

  describe 'left and right are attributes' do
    describe 'and equivalent' do
      let(:inequality) { Logic::Predicate::Inequality.new(attribute, attribute) }

      it { should equal(Logic::Proposition::False.instance) }
    end

    describe 'and are not joinable' do
      let(:other)      { Attribute::String.new(:other)                      }
      let(:inequality) { Logic::Predicate::Inequality.new(attribute, other) }

      it { should equal(Logic::Proposition::True.instance) }
    end

    describe 'and are joinable' do
      let(:other)      { Attribute::Numeric.new(:other)                     }
      let(:inequality) { Logic::Predicate::Inequality.new(attribute, other) }

      it { should equal(inequality) }
    end
  end

  describe 'left is an attribute' do
    describe 'right is a valid value' do
      let(:inequality) { Logic::Predicate::Inequality.new(attribute, 1) }

      it { should equal(inequality) }
    end

    describe 'right is an invalid value' do
      let(:inequality) { Logic::Predicate::Inequality.new(attribute, 'a') }

      it { should equal(Logic::Proposition::True.instance) }
    end
  end

  describe 'right is an attribute' do
    describe 'left is a valid value' do
      let(:inequality) { Logic::Predicate::Inequality.new(1, attribute) }

      it { should eql(Logic::Predicate::Inequality.new(attribute, 1)) }
    end

    describe 'left is an invalid value' do
      let(:inequality) { Logic::Predicate::Inequality.new('a', attribute) }

      it { should equal(Logic::Proposition::True.instance) }
    end
  end

  describe 'left and right are constants' do
    describe 'that will evaluate to true' do
      let(:inequality) { Logic::Predicate::Inequality.new(1, 2) }

      it { should equal(Logic::Proposition::True.instance) }
    end

    describe 'that will evaluate to false' do
      let(:inequality) { Logic::Predicate::Inequality.new(1, 1) }

      it { should equal(Logic::Proposition::False.instance) }
    end
  end
end
