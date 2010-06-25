require 'spec_helper'

describe 'Veritas::Logic::Predicate::GreaterThanOrEqualTo#optimize' do
  subject { greater_than_or_equal_to.optimize }

  let(:attribute) { Attribute::Integer.new(:id, :required => false) }

  context 'left and right are attributes' do
    context 'and equivalent' do
      let(:greater_than_or_equal_to) { Logic::Predicate::GreaterThanOrEqualTo.new(attribute, attribute) }

      it { should equal(Logic::Proposition::True.instance) }

      it_should_behave_like 'an optimize method'
    end

    context 'and are not comparable' do
      let(:other)                    { Attribute::Float.new(:float)                                 }
      let(:greater_than_or_equal_to) { Logic::Predicate::GreaterThanOrEqualTo.new(attribute, other) }

      it { should equal(Logic::Proposition::False.instance) }

      it_should_behave_like 'an optimize method'
    end

    context 'and left is always less than right' do
      let(:left)                     { attribute                                               }
      let(:right)                    { Attribute::Integer.new(:right, :size => 2**31..2**31)   }
      let(:greater_than_or_equal_to) { Logic::Predicate::GreaterThanOrEqualTo.new(left, right) }

      it { should equal(Logic::Proposition::False.instance) }

      it_should_behave_like 'an optimize method'
    end

    context 'and left is always greater than right' do
      let(:left)                     { attribute                                               }
      let(:right)                    { Attribute::Integer.new(:right, :size => -1..-1)         }
      let(:greater_than_or_equal_to) { Logic::Predicate::GreaterThanOrEqualTo.new(left, right) }

      it { should equal(Logic::Proposition::True.instance) }

      it_should_behave_like 'an optimize method'
    end
  end

  context 'left is an attribute' do
    context 'right is a valid value' do
      let(:greater_than_or_equal_to) { Logic::Predicate::GreaterThanOrEqualTo.new(attribute, 1) }

      it { should equal(greater_than_or_equal_to) }

      it_should_behave_like 'an optimize method'
    end

    context 'right is an invalid primitive' do
      let(:greater_than_or_equal_to) { Logic::Predicate::GreaterThanOrEqualTo.new(attribute, nil) }

      it { should equal(Logic::Proposition::False.instance) }

      it_should_behave_like 'an optimize method'
    end
  end

  context 'right is an attribute' do
    context 'left is a valid value' do
      let(:greater_than_or_equal_to) { Logic::Predicate::GreaterThanOrEqualTo.new(1, attribute) }

      it { should eql(Logic::Predicate::LessThanOrEqualTo.new(attribute, 1)) }

      it_should_behave_like 'an optimize method'
    end

    context 'left is an invalid primitive' do
      let(:greater_than_or_equal_to) { Logic::Predicate::GreaterThanOrEqualTo.new(nil, attribute) }

      it { should equal(Logic::Proposition::False.instance) }

      it_should_behave_like 'an optimize method'
    end
  end

  context 'left and right are constants' do
    context 'that will evaluate to true' do
      let(:greater_than_or_equal_to) { Logic::Predicate::GreaterThanOrEqualTo.new(1, 1) }

      it { should equal(Logic::Proposition::True.instance) }

      it_should_behave_like 'an optimize method'
    end

    context 'that will evaluate to false' do
      let(:greater_than_or_equal_to) { Logic::Predicate::GreaterThanOrEqualTo.new(1, 2) }

      it { should equal(Logic::Proposition::False.instance) }

      it_should_behave_like 'an optimize method'
    end
  end
end
