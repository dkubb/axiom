require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute#valid_primitive?' do
  before do
    @attribute = Attribute::Integer.new(:id)
  end

  subject { @attribute.valid_primitive?(@value) }

  describe 'with a valid value' do
    before do
      @value = 1
    end

    it { should be_true }
  end

  describe 'with an invalid value' do
    before do
      @value = 'a'
    end

    it { should be_false }
  end
end
