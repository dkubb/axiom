require File.expand_path('../../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Algebra::Restriction::Predicate#eql?' do
  before do
    @attribute = Attribute::Integer.new(:id)
    @predicate = PredicateSpecs::Object.new(@attribute, 1)
  end

  subject { @predicate.eql?(@other) }

  describe 'with the same predicate' do
    before do
      @other = @predicate
    end

    it { should be_true }

    it 'is symmetric' do
      should == @other.eql?(@predicate)
    end
  end

  describe 'with an equivalent predicate' do
    before do
      @other = @predicate.dup
    end

    it { should be_true }

    it 'is symmetric' do
      should == @other.eql?(@predicate)
    end
  end

  describe 'with a different predicate' do
    before do
      @attribute = Attribute::String.new(:name)
      @other     = PredicateSpecs::Object.new(@attribute, 1)
    end

    it { should be_false }

    it 'is symmetric' do
      should == @other.eql?(@predicate)
    end
  end

  describe 'with an equivalent predicate of a different class' do
    before do
      klass = Class.new(PredicateSpecs::Object)

      @other = klass.new(@attribute, 1)
    end

    it { should be_false }

    it 'is symmetric' do
      should == @other.eql?(@predicate)
    end
  end
end
