require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute#joinable?' do
  before do
    @attribute = Attribute::Integer.new(:id)
  end

  subject { @attribute.joinable?(@other) }

  describe 'when the other attribute is the same type' do
    before do
      @other = @attribute.dup
    end

    it { should be_true }

    it 'should be symmetric' do
      should == @other.joinable?(@attribute)
    end
  end

  describe 'when the other attribute is a different class' do
    before do
      @other = Attribute::String.new(:different)
    end

    it { should be_false }

    it 'should be symmetric' do
      should == @other.joinable?(@attribute)
    end
  end

  describe 'when the other attribute is a descendant type' do
    before do
      @other = Class.new(Attribute::Integer).new(:descendant)
    end

    it { should be_true }

    it 'should be symmetric' do
      should == @other.joinable?(@attribute)
    end
  end

  describe 'when the other attribute shares a common type' do
    before do
      @other = Attribute::Numeric.new(:ancestor)
    end

    it { should be_true }

    it 'should be symmetric' do
      should == @other.joinable?(@attribute)
    end
  end
end
