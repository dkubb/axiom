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

    it { should eql(@left) }
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
end
