require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute::String#length' do
  subject { @attribute.length }

  describe 'without :length option passed to constructor' do
    before do
      @attribute = Attribute::String.new(:name)
    end

    it { should == (0..50) }
  end

  describe 'with :length option passed to constructor' do
    before do
      @attribute = Attribute::String.new(:name, :length => 1..100)
    end

    it { should == (1..100) }
  end
end
