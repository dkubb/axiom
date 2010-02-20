require File.expand_path('../../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Algebra::Restriction::Predicate#optimize' do
  before do
    @attribute = Attribute::Integer.new(:id)
  end

  subject { @predicate.optimize }

  describe 'left is an attribute' do
    before do
      @predicate = PredicateSpecs::Object.new(@attribute, 1)
    end

    it 'should equal the predicate' do
      should equal(@predicate)
    end
  end

  describe 'right is an attribute' do
    before do
      @predicate = PredicateSpecs::Object.new(1, @attribute)
    end

    it 'should equal the predicate' do
      should equal(@predicate)
    end
  end

  describe 'left and right are not attributes' do
    before do
      @predicate = PredicateSpecs::Object.new(1, 1)
    end

    it 'should send the left and right value to self.class.eval' do
      PredicateSpecs::Object.should_receive(:eval).with(1, 1).and_return(true)
      should == Algebra::Restriction::True.instance
    end
  end

  describe 'left and right are nil' do
    before do
      @predicate = PredicateSpecs::Object.new(nil, nil)
    end

    it { should == Algebra::Restriction::False.instance }
  end
end
