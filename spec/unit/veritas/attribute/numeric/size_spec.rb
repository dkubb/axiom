require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute::Numeric#size' do
  subject { @attribute.size }

  describe 'without :size option passed to constructor' do
    before do
      @attribute = Attribute::Numeric.new(:id)
    end

    it { should == (0..2**31-1) }
  end

  describe 'with :size option passed to constructor' do
    before do
      @attribute = Attribute::Numeric.new(:id, :size => 1..100)
    end

    it { should == (1..100) }
  end
end
