require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order::Direction#eql?' do
  before do
    @attribute = Attribute::Integer.new(:id)
    @klass     = Class.new(Relation::Operation::Order::Direction)

    @direction = @klass.new(@attribute)
  end

  subject { @direction.eql?(@other) }

  describe 'with the same direction' do
    before do
      @other = @direction
    end

    it { should be_true }

    it 'should be symmetric' do
      should == @other.eql?(@direction)
    end
  end

  describe 'with an equivalent direction' do
    before do
      @other = @direction.dup
    end

    it { should be_true }

    it 'should be symmetric' do
      should == @other.eql?(@direction)
    end
  end

  describe 'with a different direction' do
    before do
      @attribute = Attribute::String.new(:name)

      @direction = @klass.new(@attribute)
    end

    it { should be_false }

    it 'should be symmetric' do
      should == @other.eql?(@direction)
    end
  end

  describe 'with an equivalent direction of a different class' do
    before do
      klass = Class.new(@klass)

      @direction = klass.new(@attribute)
    end

    it { should be_false }

    it 'should be symmetric' do
      should == @other.eql?(@direction)
    end
  end
end
