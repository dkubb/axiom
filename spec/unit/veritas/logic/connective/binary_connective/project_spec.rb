require File.expand_path('../../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Connective::BinaryConnective#project' do
  before do
    @attribute  = Attribute::Integer.new(:id)
    @other      = Attribute::Integer.new(:other_id)
    @attributes = [ @attribute ]
  end

  subject { @connective.project(@attributes) }

  describe 'left and right is removed' do
    before do
      @left  = @other.eq(1)
      @right = @other.eq(2)

      @connective = BinaryConnectiveSpecs::Object.new(@left, @right)
    end

    it { should be_nil }
  end

  describe 'left is removed' do
    before do
      @left  = @other.eq(1)
      @right = @attribute.eq(2)

      @connective = BinaryConnectiveSpecs::Object.new(@left, @right)
    end

    it { should equal(@right) }
  end

  describe 'right is removed' do
    before do
      @left  = @attribute.eq(1)
      @right = @other.eq(2)

      @connective = BinaryConnectiveSpecs::Object.new(@left, @right)
    end

    it { should equal(@left) }
  end

  describe 'neither left or right is removed' do
    before do
      @left  = @attribute.eq(1)
      @right = @attribute.eq(2)

      @connective = BinaryConnectiveSpecs::Object.new(@left, @right)
    end

    it 'delegates to super, but no #project in superclass' do
      method(:subject).should raise_error(NoMethodError)
    end
  end
end
