require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute#eql?' do
  before do
    @name = :id

    @attribute = Attribute::Integer.new(@name)
  end

  subject { @attribute.eql?(@other) }

  describe 'with the same attribute' do
    before do
      @other = @attribute
    end

    it { should be(true) }

    it 'is symmetric' do
      should == @other.eql?(@attribute)
    end
  end

  describe 'with an equivalent attribute' do
    before do
      @other = @attribute.dup
    end

    it { should be(true) }

    it 'is symmetric' do
      should == @other.eql?(@attribute)
    end
  end

  describe 'with a different attribute' do
    before do
      @other = Attribute::String.new(:name)
    end

    it { should be(false) }

    it 'is symmetric' do
      should == @other.eql?(@attribute)
    end
  end

  describe 'with an equivalent attribute of a different class' do
    before do
      klass = Class.new(Attribute::Integer)

      @other = klass.new(@name)
    end

    it { should be(false) }

    it 'is symmetric' do
      should == @other.eql?(@attribute)
    end
  end

  describe 'with a joinable attribute' do
    before do
      @other = @attribute.class.new(@attribute.name, :size => 1..100)
    end

    it { should be(true) }

    it 'is symmetric' do
      should == @other.eql?(@attribute)
    end
  end
end
