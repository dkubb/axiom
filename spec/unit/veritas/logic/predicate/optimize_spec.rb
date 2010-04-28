require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Predicate#optimize' do
  before do
    @attribute = Attribute::Integer.new(:id)
  end

  subject { @predicate.optimize }

  describe 'left is an attribute' do
    before do
      @predicate = PredicateSpecs::Object.new(@attribute, 1)
    end

    it 'equals the predicate' do
      should equal(@predicate)
    end
  end

  describe 'right is an attribute' do
    before do
      @predicate = PredicateSpecs::Object.new(1, @attribute)
    end

    it 'equals the predicate' do
      should equal(@predicate)
    end
  end

  describe 'left and right are not attributes' do
    before do
      @predicate = PredicateSpecs::Object.new(1, 1)
    end

    it 'sends the left and right value to self.class.eval' do
      PredicateSpecs::Object.should_receive(:eval).with(1, 1).and_return(true)
      should equal(Logic::Proposition::True.instance)
    end
  end

  describe 'left and right are nil' do
    before do
      @predicate = PredicateSpecs::Object.new(nil, nil)
    end

    it { should equal(Logic::Proposition::False.instance) }
  end
end
