require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute#eql?' do
  before do
    @name = :id
    @type = Integer

    @attribute = Attribute.new(@name, @type)
  end

  subject { @attribute.eql?(@other) }

  describe 'with an equivalent attribute' do
    before do
      @other = @attribute.dup
    end

    it { should be_true }
  end

  describe 'with a different attribute' do
    before do
      @other = Attribute.new(:name, String)
    end

    it { should be_false }
  end

  describe 'with an equivalent attribute of a different class' do
    before do
      klass = Class.new(Attribute)

      @other = klass.new(@name, @type)
    end

    it { should be_false }

    it 'should otherwise be equivalent' do
      @attribute.should == @other
    end
  end
end
