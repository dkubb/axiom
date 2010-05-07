require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute::Numeric#joinable?' do
  let(:attribute) { Attribute::Numeric.new(:numeric, :size => 10..20) }

  subject { attribute.joinable?(other) }

  context 'when the other attribute is the same type' do
    context 'and the start of the other size falls within range' do
      let(:other) { Attribute::Numeric.new(:numeric, :size => 20..30) }

      it { should be(true) }

      it 'is symmetric' do
        should == other.joinable?(attribute)
      end
    end

    context 'and the end of the other size falls within range' do
      let(:other) { Attribute::Numeric.new(:numeric, :size => 1..10) }

      it { should be(true) }

      it 'is symmetric' do
        should == other.joinable?(attribute)
      end
    end

    context 'and the other size is outside the range' do
      let(:other) { Attribute::Numeric.new(:numeric, :size => 21..30) }

      it { should be(false) }

      it 'is symmetric' do
        should == other.joinable?(attribute)
      end
    end
  end

  context 'when the other attribute is a different class' do
    let(:other) { Attribute::String.new(:different) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.joinable?(attribute)
    end
  end
end
