require 'spec_helper'

describe 'Veritas::Logic::Predicate::LessThanOrEqualTo#optimize' do
  subject { object.optimize }

  let(:klass)     { Logic::Predicate::LessThanOrEqualTo             }
  let(:attribute) { Attribute::Integer.new(:id, :required => false) }
  let(:left)      { attribute                                       }
  let(:right)     { attribute                                       }
  let(:object)    { klass.new(left, right)                          }

  context 'left and right are attributes' do
    context 'and equivalent' do
      it { should equal(Logic::Proposition::True.instance) }

      it_should_behave_like 'an optimize method'
    end

    context 'and are not comparable' do
      let(:right) { Attribute::Float.new(:float) }

      it { should equal(Logic::Proposition::False.instance) }

      it_should_behave_like 'an optimize method'
    end

    context 'and left is always less than right' do
      let(:left)  { attribute                                             }
      let(:right) { Attribute::Integer.new(:right, :size => 2**31..2**31) }

      it { should equal(Logic::Proposition::True.instance) }

      it_should_behave_like 'an optimize method'
    end

    context 'and left is always greater than right' do
      let(:left)  { attribute                                       }
      let(:right) { Attribute::Integer.new(:right, :size => -1..-1) }

      it { should equal(Logic::Proposition::False.instance) }

      it_should_behave_like 'an optimize method'
    end
  end

  context 'left is an attribute' do
    context 'right is a valid value' do
      let(:right) { 1 }

      it { should equal(object) }

      it_should_behave_like 'an optimize method'
    end

    context 'right is an invalid primitive' do
      let(:right) { nil }

      it { should equal(Logic::Proposition::False.instance) }

      it_should_behave_like 'an optimize method'
    end
  end

  context 'right is an attribute' do
    context 'left is a valid value' do
      let(:left) { 1 }

      it { should eql(Logic::Predicate::GreaterThanOrEqualTo.new(attribute, 1)) }

      it_should_behave_like 'an optimize method'
    end

    context 'left is an invalid primitive' do
      let(:left) { nil }

      it { should equal(Logic::Proposition::False.instance) }

      it_should_behave_like 'an optimize method'
    end
  end

  context 'left and right are constants' do
    context 'that will evaluate to true' do
      let(:left)  { 1 }
      let(:right) { 1 }

      it { should equal(Logic::Proposition::True.instance) }

      it_should_behave_like 'an optimize method'
    end

    context 'that will evaluate to false' do
      let(:left)  { 2 }
      let(:right) { 1 }

      it { should equal(Logic::Proposition::False.instance) }

      it_should_behave_like 'an optimize method'
    end
  end
end
