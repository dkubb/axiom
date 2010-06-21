require 'spec_helper'

describe 'Veritas::Logic::Predicate::GreaterThan#optimize' do
  subject { greater_than.optimize }

  let(:attribute) { Attribute::Integer.new(:id, :required => false) }

  context 'left and right are attributes' do
    context 'and equivalent' do
      let(:greater_than) { Logic::Predicate::GreaterThan.new(attribute, attribute) }

      it { should equal(Logic::Proposition::False.instance) }

      it_should_behave_like 'an idempotent method'
    end

    context 'and are not comparable' do
      let(:other)        { Attribute::Float.new(:float)                        }
      let(:greater_than) { Logic::Predicate::GreaterThan.new(attribute, other) }

      it { should equal(Logic::Proposition::False.instance) }

      it_should_behave_like 'an idempotent method'
    end

    context 'and left is always less than or equal to right' do
      let(:left)         { attribute                                                 }
      let(:right)        { Attribute::Integer.new(:right, :size => 2**31-1..2**31-1) }
      let(:greater_than) { Logic::Predicate::GreaterThan.new(left, right)            }

      it { should equal(Logic::Proposition::False.instance) }

      it_should_behave_like 'an idempotent method'
    end

    context 'and left is always greater than right' do
      let(:left)         { attribute                                       }
      let(:right)        { Attribute::Integer.new(:right, :size => -1..-1) }
      let(:greater_than) { Logic::Predicate::GreaterThan.new(left, right)  }

      it { should equal(Logic::Proposition::True.instance) }

      it_should_behave_like 'an idempotent method'
    end
  end

  context 'left is an attribute' do
    context 'right is a valid value' do
      let(:greater_than) { Logic::Predicate::GreaterThan.new(attribute, 1) }

      it { should equal(greater_than) }

      it_should_behave_like 'an idempotent method'
    end

    context 'right is an invalid primitive' do
      let(:greater_than) { Logic::Predicate::GreaterThan.new(attribute, nil) }

      it { should equal(Logic::Proposition::False.instance) }

      it_should_behave_like 'an idempotent method'
    end
  end

  context 'right is an attribute' do
    context 'left is a valid value' do
      let(:greater_than) { Logic::Predicate::GreaterThan.new(1, attribute) }

      it { should eql(Logic::Predicate::LessThan.new(attribute, 1)) }

      it_should_behave_like 'an idempotent method'
    end

    context 'left is an invalid primitive' do
      let(:greater_than) { Logic::Predicate::GreaterThan.new(nil, attribute) }

      it { should equal(Logic::Proposition::False.instance) }

      it_should_behave_like 'an idempotent method'
    end
  end

  context 'left and right are constants' do
    context 'that will evaluate to true' do
      let(:greater_than) { Logic::Predicate::GreaterThan.new(2, 1) }

      it { should equal(Logic::Proposition::True.instance) }

      it_should_behave_like 'an idempotent method'
    end

    context 'that will evaluate to false' do
      let(:greater_than) { Logic::Predicate::GreaterThan.new(1, 2) }

      it { should equal(Logic::Proposition::False.instance) }

      it_should_behave_like 'an idempotent method'
    end
  end
end
