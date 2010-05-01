require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Connective::Negation#eql?' do
  before do
    @attribute = Attribute::Integer.new(:id)
    @operand = @attribute.eq(1)

    @negation = Logic::Connective::Negation.new(@operand)
  end

  subject { @negation.eql?(@other) }

  describe 'with the same negation' do
    before do
      @other = @negation
    end

    it { should be(true) }

    it 'is symmetric' do
      should == @other.eql?(@negation)
    end
  end

  describe 'with an equivalent negation' do
    before do
      @other = @negation.dup
    end

    it { should be(true) }

    it 'is symmetric' do
      should == @other.eql?(@negation)
    end
  end

  describe 'with a different negation' do
    before do
      @attribute = Attribute::String.new(:name)
      @operand   = @attribute.eq('Dan Kubb')
      @other     = Logic::Connective::Negation.new(@operand)
    end

    it { should be(false) }

    it 'is symmetric' do
      should == @other.eql?(@negation)
    end
  end

  describe 'with an equivalent negation of a different class' do
    before do
      klass = Class.new(Logic::Connective::Negation)

      @other = klass.new(@operand)
    end

    it { should be(false) }

    it 'is symmetric' do
      should == @other.eql?(@negation)
    end
  end
end
