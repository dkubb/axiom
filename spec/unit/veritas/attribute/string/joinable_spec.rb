require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute::String#joinable?' do
  before do
    @attribute = Attribute::String.new(:string, :length => 10..20)
  end

  subject { @attribute.joinable?(@other) }

  describe 'when the other attribute is the same type' do
    describe 'and the start of the other length falls within range' do
      before do
        @other = Attribute::String.new(:string, :length => 20..30)
      end

      it { should be(true) }

      it 'is symmetric' do
        should == @other.joinable?(@attribute)
      end
    end

    describe 'and the end of the other length falls within range' do
      before do
        @other = Attribute::String.new(:string, :length => 1..10)
      end

      it { should be(true) }

      it 'is symmetric' do
        should == @other.joinable?(@attribute)
      end
    end

    describe 'and the other length is outside the range' do
      before do
        @other = Attribute::String.new(:string, :length => 21..30)
      end

      it { should be(false) }

      it 'is symmetric' do
        should == @other.joinable?(@attribute)
      end
    end
  end

  describe 'when the other attribute is a different class' do
    before do
      @other = Attribute::Integer.new(:different)
    end

    it { should be(false) }

    it 'is symmetric' do
      should == @other.joinable?(@attribute)
    end
  end
end
