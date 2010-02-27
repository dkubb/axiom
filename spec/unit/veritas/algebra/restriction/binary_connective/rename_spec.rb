require File.expand_path('../../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Algebra::Restriction::BinaryConnective#rename' do
  before do
    @attribute = Attribute::Integer.new(:id)
    @other     = Attribute::Integer.new(:other_id)
    @aliases   = { @attribute.name => @other.name }
  end

  subject { @connective.rename(@aliases) }

  describe 'left and right are renamed' do
    before do
      @left  = @attribute.eq(1)
      @right = @attribute.eq(2)

      @connective = BinaryConnectiveSpecs::Object.new(@left, @right)
    end

    it { should eql(BinaryConnectiveSpecs::Object.new(@other.eq(1), @other.eq(2))) }
  end

  describe 'left is renamed' do
    before do
      @left  = @attribute.eq(1)
      @right = @other.eq(2)

      @connective = BinaryConnectiveSpecs::Object.new(@left, @right)
    end

    it { should eql(BinaryConnectiveSpecs::Object.new(@other.eq(1), @other.eq(2))) }
  end

  describe 'right is renamed' do
    before do
      @left  = @other.eq(1)
      @right = @attribute.eq(2)

      @connective = BinaryConnectiveSpecs::Object.new(@left, @right)
    end

    it { should eql(BinaryConnectiveSpecs::Object.new(@other.eq(1), @other.eq(2))) }
  end

  describe 'right and right are not renamed' do
    before do
      @left  = @other.eq(1)
      @right = @other.eq(2)

      @connective = BinaryConnectiveSpecs::Object.new(@left, @right)
    end

    it { should equal(@connective) }
  end
end
