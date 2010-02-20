require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute::Boolean#valid_value?' do
  before do
    @attribute = Veritas::Attribute::Boolean.new(:boolean)
  end

  subject { @attribute.valid_value?(@value) }

  describe 'with a true value' do
    before do
      @value = true
    end

    it { should be_true }
  end

  describe 'with a false value' do
    before do
      @value = false
    end

    it { should be_true }
  end

  describe 'with a value that is not true or false' do
    before do
      @value = 1
    end

    it { should be_false }
  end
end
