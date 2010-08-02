require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Predicate::Enumerable#optimize' do
  subject { enumerable.optimize }

  let(:klass)      { PredicateEnumerableSpecs::Object }
  let(:left)       { Attribute::Integer.new(:id)      }
  let(:one)        { mock('One',  :frozen? => true)   }
  let(:none)       { mock('None', :frozen? => true)   }
  let(:enumerable) { klass.new(left, right)           }

  before do
    klass.stub!(:mock_one => one, :mock_none => none)
    one.stub!(:optimize => one)
    none.stub!(:optimize => none)
  end

  context 'right is a Range' do
    context 'that is inclusive' do
      context 'and empty' do
        let(:right) { 1..0 }

        it { should equal(none) }

        it_should_behave_like 'an optimize method'
      end

      context 'and not empty' do
        let(:right) { 1..10 }

        it { should equal(enumerable) }

        it_should_behave_like 'an optimize method'
      end
    end

    context 'that is exclusive' do
      context 'and empty' do
        let(:right) { 1...1 }

        it { should equal(none) }

        it_should_behave_like 'an optimize method'
      end

      context 'and not empty' do
        let(:right) { 1...10 }

        it 'changes the Range to be inclusive' do
          should eql(klass.new(left, 1..9))
        end

        it_should_behave_like 'an optimize method'
      end
    end

    context 'using an attribute that is not comparable' do
      let(:left)  { Attribute::String.new(:string) }
      let(:right) { 'a'..'z'                       }

      it { should equal(none) }

      it_should_behave_like 'an optimize method'
    end

    context 'that is greater than the left range' do
      let(:right) { 2**31..2**31 }

      it { should equal(none) }

      it_should_behave_like 'an optimize method'
    end

    context 'that is less than the left range' do
      let(:right) { -1..-1 }

      it { should equal(none) }

      it_should_behave_like 'an optimize method'
    end

    context 'that is not optimizable' do
      let(:right) { 1..2 }

      it { should equal(enumerable) }

      it_should_behave_like 'an optimize method'
    end
  end

  context 'right is an Enumerable' do
    context 'that is empty' do
      let(:right) { [] }

      it { should equal(none) }

      it_should_behave_like 'an optimize method'
    end

    context 'that is empty after filtering invalid entries' do
      let(:right) { [ 'a' ] }

      it { should equal(none) }

      it_should_behave_like 'an optimize method'
    end

    context 'that is not empty after filtering invalid entries' do
      let(:right) { [ 'a', 1, 2 ] }

      it { should eql(klass.new(left, [ 1, 2 ])) }

      it_should_behave_like 'an optimize method'
    end

    context 'that has duplicate entries' do
      let(:right) { [ 1, 2, 2 ] }

      it { should eql(klass.new(left, [ 1, 2 ])) }

      it_should_behave_like 'an optimize method'
    end

    context 'that has one entry' do
      let(:right) { [ 1 ] }

      it { should equal(one) }

      it_should_behave_like 'an optimize method'
    end

    context 'that has unsorted entries' do
      let(:right) { [ 2, 1 ] }

      it { should eql(klass.new(left, [ 1, 2 ])) }

      it_should_behave_like 'an optimize method'
    end

    context 'that is not optimizable' do
      let(:right) { [ 1, 2 ] }

      it { should equal(enumerable) }

      it_should_behave_like 'an optimize method'
    end
  end

  context 'right is a nil' do
    let(:right) { nil }

    it { should equal(none) }

    it_should_behave_like 'an optimize method'
  end
end
