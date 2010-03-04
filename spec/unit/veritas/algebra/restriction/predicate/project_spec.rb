require File.expand_path('../../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Algebra::Restriction::Predicate#project' do
  before do
    @attribute = Attribute::Integer.new(:id)
    @other     = Attribute::Integer.new(:other_id)

    @attributes = [ @attribute ]
  end

  subject { @predicate.project(@attributes) }

  describe 'when left is an attribute' do
    describe 'and it is not removed' do
      before do
        @predicate = PredicateSpecs::Object.new(@attribute, 1)
      end

      it 'should return self' do
        should equal(@predicate)
      end
    end

    describe 'and it is removed' do
      before do
        @predicate = PredicateSpecs::Object.new(@other, 1)
      end

      it 'should return nil' do
        should be_nil
      end
    end
  end

  describe 'when right is an attribute' do
    describe 'and it is not removed' do
      before do
        @predicate = PredicateSpecs::Object.new(1, @attribute)
      end

      it 'should return self' do
        should equal(@predicate)
      end
    end

    describe 'and it is removed' do
      before do
        @predicate = PredicateSpecs::Object.new(1, @other)
      end

      it 'should return nil' do
        should be_nil
      end
    end
  end

  describe 'when neither left or right is a removed attribute' do
    before do
      @predicate = PredicateSpecs::Object.new(1, 1)
    end

    it 'should return self' do
      should equal(@predicate)
    end
  end
end
