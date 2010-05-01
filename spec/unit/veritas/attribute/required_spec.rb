require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute#required?' do
  subject { @attribute.required? }

  describe 'without :required option passed to constructor' do
    before do
      @attribute = Attribute::Integer.new(:id)
    end

    it { should be(true) }
  end

  describe 'with :required => true option passed to constructor' do
    before do
      @attribute = Attribute::Integer.new(:id, :required => true)
    end

    it { should be(true) }
  end

  describe 'with :required => false option passed to constructor' do
    before do
      @attribute = Attribute::Integer.new(:id, :required => false)
    end

    it { should be(false) }
  end
end
