require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute::Comparable#comparable?' do
  let(:attribute) { Attribute::Integer.new(:id) }

  subject { attribute.comparable?(other) }

  describe 'when the other attribute is the same type' do
    let(:other) { attribute.dup }

    it { should be(true) }

    it 'is symmetric' do
      should == other.comparable?(attribute)
    end
  end

  describe 'when the other attribute is a different class' do
    let(:other) { Attribute::String.new(:different) }

    it { should be(false) }

    it 'is not be symmetric' do
      lambda {
        other.comparable?(attribute)
      }.should raise_error(NoMethodError)
    end
  end

  describe 'when the other attribute is a descendant type' do
    let(:other) { Class.new(Attribute::Integer).new(:descendant) }

    it { should be(true) }

    it 'is symmetric' do
      should == other.comparable?(attribute)
    end
  end

  describe 'when the other attribute shares a common type' do
    let(:other) { Attribute::Numeric.new(:ancestor) }

    it { should be(true) }

    it 'is symmetric' do
      should == other.comparable?(attribute)
    end
  end
end
