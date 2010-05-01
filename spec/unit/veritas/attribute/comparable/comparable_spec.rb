require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute::Comparable#comparable?' do
  before do
    @attribute = Attribute::Integer.new(:id)
  end

  subject { @attribute.comparable?(@other) }

  describe 'when the other attribute is the same type' do
    before do
      @other = @attribute.dup
    end

    it { should be(true) }

    it 'is symmetric' do
      should == @other.comparable?(@attribute)
    end
  end

  describe 'when the other attribute is a different class' do
    before do
      @other = Attribute::String.new(:different)
    end

    it { should be(false) }

    it 'is not be symmetric' do
      lambda {
        @other.comparable?(@attribute)
      }.should raise_error(NoMethodError)
    end
  end

  describe 'when the other attribute is a descendant type' do
    before do
      @other = Class.new(Attribute::Integer).new(:descendant)
    end

    it { should be(true) }

    it 'is symmetric' do
      should == @other.comparable?(@attribute)
    end
  end

  describe 'when the other attribute shares a common type' do
    before do
      @other = Attribute::Numeric.new(:ancestor)
    end

    it { should be(true) }

    it 'is symmetric' do
      should == @other.comparable?(@attribute)
    end
  end
end
