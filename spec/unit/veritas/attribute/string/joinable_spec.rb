require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute::String#joinable?' do
  let(:attribute) { Attribute::String.new(:string, :length => 10..20) }

  subject { attribute.joinable?(other) }

  describe 'when the other attribute is the same type' do
    describe 'and the start of the other length falls within range' do
      let(:other) { Attribute::String.new(:string, :length => 20..30) }

      it { should be(true) }

      it 'is symmetric' do
        should == other.joinable?(attribute)
      end
    end

    describe 'and the end of the other length falls within range' do
      let(:other) { Attribute::String.new(:string, :length => 1..10) }

      it { should be(true) }

      it 'is symmetric' do
        should == other.joinable?(attribute)
      end
    end

    describe 'and the other length is outside the range' do
      let(:other) { Attribute::String.new(:string, :length => 21..30) }

      it { should be(false) }

      it 'is symmetric' do
        should == other.joinable?(attribute)
      end
    end
  end

  describe 'when the other attribute is a different class' do
    let(:other) { Attribute::Integer.new(:different) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.joinable?(attribute)
    end
  end
end
