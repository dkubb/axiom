require File.expand_path('../../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Algebra::Restriction::BinaryConnective#optimize' do
  before do
    @attribute = Attribute::Integer.new(:id)
  end

  subject { @connective.optimize }

  describe 'left and right are the same' do
    before do
      @left  = @attribute.gt(1)
      @right = @attribute.gt(1)

      @connective = BinaryConnectiveSpecs::Object.new(@left, @right)
    end

    it { should equal(@left) }
  end

  describe 'left and right are the same, after optimizing the left' do
    before do
      @original_left = @attribute.gt(1)
      @left          = @original_left.and(Algebra::Restriction::True.instance)
      @right         = @attribute.gt(1)

      @connective = BinaryConnectiveSpecs::Object.new(@left, @right)
    end

    it { should equal(@original_left) }
  end

  describe 'left and right are the same, after optimizing the right' do
    before do
      @left  = @attribute.gt(1)
      @right = @attribute.gt(1).and(Algebra::Restriction::True.instance)

      @connective = BinaryConnectiveSpecs::Object.new(@left, @right)
    end

    it { should equal(@left) }
  end

  describe 'left and right are different' do
    before do
      @left  = @attribute.gt(1)
      @right = @attribute.lt(1)

      @connective = BinaryConnectiveSpecs::Object.new(@left, @right)
    end

    it 'should delegate to super, but no #optimize in superclass' do
      method(:subject).should raise_error(NoMethodError)
    end
  end

  describe 'left and right are different, after optimizing the left' do
    before do
      @original_left = @attribute.gt(1)
      @left          = @original_left.and(Algebra::Restriction::True.instance)
      @right         = @attribute.lt(1)

      @connective = BinaryConnectiveSpecs::Object.new(@left, @right)
    end

    it { should_not equal(@connective) }

    it { should be_instance_of(BinaryConnectiveSpecs::Object) }

    it { subject.left.should equal(@original_left) }

    it { subject.right.should equal(@right) }
  end

  describe 'left and right are different, after optimizing the right' do
    before do
      @original_right = @attribute.lt(1)
      @left           = @attribute.gt(1)
      @right          = @original_right.and(Algebra::Restriction::True.instance)

      @connective = BinaryConnectiveSpecs::Object.new(@left, @right)
    end

    it { should_not equal(@connective) }

    it { should be_instance_of(BinaryConnectiveSpecs::Object) }

    it { subject.left.should equal(@left) }

    it { subject.right.should equal(@original_right) }
  end

  describe 'self and right are the same, and left and right.left are the same' do
    before do
      mod = Module.new do
        def optimize
          self
        end
      end

      @left  = @attribute.eq(1)
      @right = BinaryConnectiveSpecs::Object.new(@attribute.eq(1), @attribute.ne(5))
      @right.extend(mod)

      @connective = BinaryConnectiveSpecs::Object.new(@left, @right)
    end

    it { should equal(@right) }
  end
end
