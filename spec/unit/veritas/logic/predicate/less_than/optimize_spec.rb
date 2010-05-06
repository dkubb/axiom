require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Predicate::LessThan#optimize' do
  let(:attribute) { Attribute::Integer.new(:id, :required => false) }

  subject { less_than.optimize }

  describe 'left and right are attributes' do
    describe 'and equivalent' do
      let(:less_than) { Logic::Predicate::LessThan.new(attribute, attribute) }

      it { should equal(Logic::Proposition::False.instance) }
    end

    describe 'and are not comparable' do
      let(:other)     { Attribute::Float.new(:float)                     }
      let(:less_than) { Logic::Predicate::LessThan.new(attribute, other) }

      it { should equal(Logic::Proposition::False.instance) }
    end

    describe 'and left is always less than right' do
      let(:left)      { attribute                                             }
      let(:right)     { Attribute::Integer.new(:right, :size => 2**31..2**31) }
      let(:less_than) { Logic::Predicate::LessThan.new(left, right)           }

      it { should equal(Logic::Proposition::True.instance) }
    end

    describe 'and left is always greater than or equal to right' do
      let(:left)      { attribute                                     }
      let(:right)     { Attribute::Integer.new(:right, :size => 0..0) }
      let(:less_than) { Logic::Predicate::LessThan.new(left, right)   }

      it { should equal(Logic::Proposition::False.instance) }
    end
  end

  describe 'left is an attribute' do
    describe 'right is a valid value' do
      let(:less_than) { Logic::Predicate::LessThan.new(attribute, 1) }

      it { should equal(less_than) }
    end

    describe 'right is an invalid primitive' do
      let(:less_than) { Logic::Predicate::LessThan.new(attribute, nil) }

      it { should equal(Logic::Proposition::False.instance) }
    end
  end

  describe 'right is an attribute' do
    describe 'left is a valid value' do
      let(:less_than) { Logic::Predicate::LessThan.new(1, attribute) }

      it { should eql(Logic::Predicate::GreaterThan.new(attribute, 1)) }
    end

    describe 'left is an invalid primitive' do
      let(:less_than) { Logic::Predicate::LessThan.new(nil, attribute) }

      it { should equal(Logic::Proposition::False.instance) }
    end
  end

  describe 'left and right are constants' do
    describe 'that will evaluate to true' do
      let(:less_than) { Logic::Predicate::LessThan.new(1, 2) }

      it { should equal(Logic::Proposition::True.instance) }
    end

    describe 'that will evaluate to false' do
      let(:less_than) { Logic::Predicate::LessThan.new(1, 1) }

      it { should equal(Logic::Proposition::False.instance) }
    end
  end
end
