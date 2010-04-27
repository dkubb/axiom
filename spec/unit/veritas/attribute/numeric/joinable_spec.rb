require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute::Numeric#joinable?' do
  before do
    @attribute = Attribute::Numeric.new(:numeric, :size => 10..20)
  end

  subject { @attribute.joinable?(@other) }

  describe 'when the other attribute is the same type' do
    describe 'and the start of the other size falls within range' do
      before do
        @other = Attribute::Numeric.new(:numeric, :size => 20..30)
      end

      it { should be_true }

      it 'is symmetric' do
        should == @other.joinable?(@attribute)
      end
    end

    describe 'and the end of the other size falls within range' do
      before do
        @other = Attribute::Numeric.new(:numeric, :size => 1..10)
      end

      it { should be_true }

      it 'is symmetric' do
        should == @other.joinable?(@attribute)
      end
    end

    describe 'and the other size is outside the range' do
      before do
        @other = Attribute::Numeric.new(:numeric, :size => 21..30)
      end

      it { should be_false }

      it 'is symmetric' do
        should == @other.joinable?(@attribute)
      end
    end
  end

  describe 'when the other attribute is a different class' do
    before do
      @other = Attribute::String.new(:different)
    end

    it { should be_false }

    it 'is symmetric' do
      should == @other.joinable?(@attribute)
    end
  end
end
