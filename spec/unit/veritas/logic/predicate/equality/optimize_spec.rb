require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Predicate::Equality#optimize' do
  subject { equality.optimize }

  let(:attribute) { Attribute::Integer.new(:id) }

  context 'left and right are attributes' do
    context 'and equivalent' do
      let(:equality) { Logic::Predicate::Equality.new(attribute, attribute) }

      it { should equal(Logic::Proposition::True.instance) }
    end

    context 'and are not joinable' do
      let(:other)    { Attribute::String.new(:other)                    }
      let(:equality) { Logic::Predicate::Equality.new(attribute, other) }

      it { should equal(Logic::Proposition::False.instance) }
    end

    context 'and are joinable' do
      let(:other)    { Attribute::Numeric.new(:other)                   }
      let(:equality) { Logic::Predicate::Equality.new(attribute, other) }

      it { should equal(equality) }
    end
  end

  context 'left is an attribute' do
    context 'right is a valid value' do
      let(:equality) { Logic::Predicate::Equality.new(attribute, 1) }

      it { should equal(equality) }
    end

    context 'right is an invalid value' do
      let(:equality) { Logic::Predicate::Equality.new(attribute, 'a') }

      it { should equal(Logic::Proposition::False.instance) }
    end
  end

  context 'right is an attribute' do
    context 'left is a valid value' do
      let(:equality) { Logic::Predicate::Equality.new(1, attribute) }

      it { should eql(Logic::Predicate::Equality.new(attribute, 1)) }
    end

    context 'left is an invalid value' do
      let(:equality) { Logic::Predicate::Equality.new('a', attribute) }

      it { should equal(Logic::Proposition::False.instance) }
    end
  end

  context 'left and right are constants' do
    context 'that will evaluate to true' do
      let(:equality) { Logic::Predicate::Equality.new(1, 1) }

      it { should equal(Logic::Proposition::True.instance) }
    end

    context 'that will evaluate to false' do
      let(:equality) { Logic::Predicate::Equality.new(1, 2) }

      it { should equal(Logic::Proposition::False.instance) }
    end
  end
end
