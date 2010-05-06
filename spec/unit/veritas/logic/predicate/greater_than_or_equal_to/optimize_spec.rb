require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Predicate::GreaterThanOrEqualTo#optimize' do
  let(:attribute) { Attribute::Integer.new(:id, :required => false) }

  subject { greater_than_or_equal_to.optimize }

  describe 'left and right are attributes' do
    describe 'and equivalent' do
      let(:greater_than_or_equal_to) { Logic::Predicate::GreaterThanOrEqualTo.new(attribute, attribute) }

      it { should equal(Logic::Proposition::True.instance) }
    end

    describe 'and are not comparable' do
      let(:other)                    { Attribute::Float.new(:float)                                 }
      let(:greater_than_or_equal_to) { Logic::Predicate::GreaterThanOrEqualTo.new(attribute, other) }

      it { should equal(Logic::Proposition::False.instance) }
    end

    describe 'and left is always less than right' do
      let(:left)                     { attribute                                               }
      let(:right)                    { Attribute::Integer.new(:right, :size => 2**31..2**31)   }
      let(:greater_than_or_equal_to) { Logic::Predicate::GreaterThanOrEqualTo.new(left, right) }

      it { should equal(Logic::Proposition::False.instance) }
    end

    describe 'and left is always greater than right' do
      let(:left)                     { attribute                                               }
      let(:right)                    { Attribute::Integer.new(:right, :size => -1..-1)         }
      let(:greater_than_or_equal_to) { Logic::Predicate::GreaterThanOrEqualTo.new(left, right) }

      it { should equal(Logic::Proposition::True.instance) }
    end
  end

  describe 'left is an attribute' do
    describe 'right is a valid value' do
      let(:greater_than_or_equal_to) { Logic::Predicate::GreaterThanOrEqualTo.new(attribute, 1) }

      it { should equal(greater_than_or_equal_to) }
    end

    describe 'right is an invalid primitive' do
      let(:greater_than_or_equal_to) { Logic::Predicate::GreaterThanOrEqualTo.new(attribute, nil) }

      it { should equal(Logic::Proposition::False.instance) }
    end
  end

  describe 'right is an attribute' do
    describe 'left is a valid value' do
      let(:greater_than_or_equal_to) { Logic::Predicate::GreaterThanOrEqualTo.new(1, attribute) }

      it { should eql(Logic::Predicate::LessThanOrEqualTo.new(attribute, 1)) }
    end

    describe 'left is an invalid primitive' do
      let(:greater_than_or_equal_to) { Logic::Predicate::GreaterThanOrEqualTo.new(nil, attribute) }

      it { should equal(Logic::Proposition::False.instance) }
    end
  end

  describe 'left and right are constants' do
    describe 'that will evaluate to true' do
      let(:greater_than_or_equal_to) { Logic::Predicate::GreaterThanOrEqualTo.new(1, 1) }

      it { should equal(Logic::Proposition::True.instance) }
    end

    describe 'that will evaluate to false' do
      let(:greater_than_or_equal_to) { Logic::Predicate::GreaterThanOrEqualTo.new(1, 2) }

      it { should equal(Logic::Proposition::False.instance) }
    end
  end
end
