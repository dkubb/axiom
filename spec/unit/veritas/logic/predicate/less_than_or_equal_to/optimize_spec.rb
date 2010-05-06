require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Predicate::LessThanOrEqualTo#optimize' do
  let(:attribute) { Attribute::Integer.new(:id, :required => false) }

  subject { less_than_or_equal_to.optimize }

  describe 'left and right are attributes' do
    describe 'and equivalent' do
      let(:less_than_or_equal_to) { Logic::Predicate::LessThanOrEqualTo.new(attribute, attribute) }

      it { should equal(Logic::Proposition::True.instance) }
    end

    describe 'and are not comparable' do
      let(:other)                 { Attribute::Float.new(:float)                              }
      let(:less_than_or_equal_to) { Logic::Predicate::LessThanOrEqualTo.new(attribute, other) }

      it { should equal(Logic::Proposition::False.instance) }
    end

    describe 'and left is always less than right' do
      let(:left)                  { attribute                                             }
      let(:right)                 { Attribute::Integer.new(:right, :size => 2**31..2**31) }
      let(:less_than_or_equal_to) { Logic::Predicate::LessThanOrEqualTo.new(left, right)  }

      it { should equal(Logic::Proposition::True.instance) }
    end

    describe 'and left is always greater than right' do
      let(:left)                  { attribute                                            }
      let(:right)                 { Attribute::Integer.new(:right, :size => -1..-1)      }
      let(:less_than_or_equal_to) { Logic::Predicate::LessThanOrEqualTo.new(left, right) }

      it { should equal(Logic::Proposition::False.instance) }
    end
  end

  describe 'left is an attribute' do
    describe 'right is a valid value' do
      let(:less_than_or_equal_to) { Logic::Predicate::LessThanOrEqualTo.new(attribute, 1) }

      it { should equal(less_than_or_equal_to) }
    end

    describe 'right is an invalid primitive' do
      let(:less_than_or_equal_to) { Logic::Predicate::LessThanOrEqualTo.new(attribute, nil) }

      it { should equal(Logic::Proposition::False.instance) }
    end
  end

  describe 'right is an attribute' do
    describe 'left is a valid value' do
      let(:less_than_or_equal_to) { Logic::Predicate::LessThanOrEqualTo.new(1, attribute) }

      it { should eql(Logic::Predicate::GreaterThanOrEqualTo.new(attribute, 1)) }
    end

    describe 'left is an invalid primitive' do
      let(:less_than_or_equal_to) { Logic::Predicate::LessThanOrEqualTo.new(nil, attribute) }

      it { should equal(Logic::Proposition::False.instance) }
    end
  end

  describe 'left and right are constants' do
    describe 'that will evaluate to true' do
      let(:less_than_or_equal_to) { Logic::Predicate::LessThanOrEqualTo.new(1, 1) }

      it { should equal(Logic::Proposition::True.instance) }
    end

    describe 'that will evaluate to false' do
      let(:less_than_or_equal_to) { Logic::Predicate::LessThanOrEqualTo.new(2, 1) }

      it { should equal(Logic::Proposition::False.instance) }
    end
  end
end
