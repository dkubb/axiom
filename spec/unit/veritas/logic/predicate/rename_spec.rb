require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Predicate#rename' do
  before do
    @attribute = Attribute::Integer.new(:id)
    @other     = Attribute::Integer.new(:other_id)

    @aliases = { @attribute.name => @other.name }
  end

  subject { @predicate.rename(@aliases) }

  describe 'when the left and right are expressions' do
    before do
      @predicate = PredicateSpecs::Object.new(@attribute, @attribute)
    end

    it 'renames the matching expressions' do
      should eql(PredicateSpecs::Object.new(@other, @other))
    end
  end

  describe 'when the left is an expression, and the right is a value' do
    before do
      @predicate = PredicateSpecs::Object.new(@attribute, 1)
    end

    it 'renames the matching expressions' do
      should eql(PredicateSpecs::Object.new(@other, 1))
    end
  end

  describe 'when the right is an expression, and the left is a value' do
    before do
      @predicate = PredicateSpecs::Object.new(1, @attribute)
    end

    it 'renames the matching expressions' do
      should eql(PredicateSpecs::Object.new(1, @other))
    end
  end

  describe 'when the left and right are values' do
    before do
      @predicate = PredicateSpecs::Object.new(1, 1)
    end

    it 'does nothing' do
      should equal(@predicate)
    end
  end
end
