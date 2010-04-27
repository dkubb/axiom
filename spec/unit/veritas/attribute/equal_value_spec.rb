require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute#==' do
  before do
    @name = :id

    @attribute = Attribute::Integer.new(@name)
  end

  subject { @attribute == @other }

  describe 'with the same attribute' do
    before do
      @other = @attribute
    end

    it { should be_true }

    it 'is symmetric' do
      should == (@other == @attribute)
    end
  end

  describe 'with an equivalent attribute' do
    before do
      @other = @attribute.dup
    end

    it { should be_true }

    it 'is symmetric' do
      should == (@other == @attribute)
    end
  end

  describe 'with a different attribute' do
    before do
      @other = Attribute::String.new(:name)
    end

    it { should be_false }

    it 'is symmetric' do
      should == (@other == @attribute)
    end
  end

  describe 'with an equivalent attribute of a different class' do
    before do
      klass = Class.new(Attribute::Integer)

      @other = klass.new(@name)
    end

    it { should be_true }

    it 'is symmetric' do
      should == (@other == @attribute)
    end
  end
end
