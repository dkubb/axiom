require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Predicate::Inequality#optimize' do
  subject { inequality.optimize }

  let(:attribute) { Attribute::Integer.new(:id) }

  context 'left and right are attributes' do
    context 'and equivalent' do
      let(:inequality) { Logic::Predicate::Inequality.new(attribute, attribute) }

      it { should equal(Logic::Proposition::False.instance) }
    end

    context 'and are not joinable' do
      let(:other)      { Attribute::String.new(:other)                      }
      let(:inequality) { Logic::Predicate::Inequality.new(attribute, other) }

      it { should equal(Logic::Proposition::True.instance) }
    end

    context 'and are joinable' do
      let(:other)      { Attribute::Numeric.new(:other)                     }
      let(:inequality) { Logic::Predicate::Inequality.new(attribute, other) }

      it { should equal(inequality) }
    end
  end

  context 'left is an attribute' do
    context 'right is a valid value' do
      let(:inequality) { Logic::Predicate::Inequality.new(attribute, 1) }

      it { should equal(inequality) }
    end

    context 'right is an invalid value' do
      let(:inequality) { Logic::Predicate::Inequality.new(attribute, 'a') }

      it { should equal(Logic::Proposition::True.instance) }
    end
  end

  context 'right is an attribute' do
    context 'left is a valid value' do
      let(:inequality) { Logic::Predicate::Inequality.new(1, attribute) }

      it { should eql(Logic::Predicate::Inequality.new(attribute, 1)) }
    end

    context 'left is an invalid value' do
      let(:inequality) { Logic::Predicate::Inequality.new('a', attribute) }

      it { should equal(Logic::Proposition::True.instance) }
    end
  end

  context 'left and right are constants' do
    context 'that will evaluate to true' do
      let(:inequality) { Logic::Predicate::Inequality.new(1, 2) }

      it { should equal(Logic::Proposition::True.instance) }
    end

    context 'that will evaluate to false' do
      let(:inequality) { Logic::Predicate::Inequality.new(1, 1) }

      it { should equal(Logic::Proposition::False.instance) }
    end
  end
end
