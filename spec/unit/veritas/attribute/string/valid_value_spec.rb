require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute::String#valid_value?' do
  before do
    @attribute = Veritas::Attribute::String.new(:string, :length => 1..50)
  end

  subject { @attribute.valid_value?(@value) }

  describe 'with a string value' do
    describe 'that is within the allowed length range' do
      before do
        @value = 'a'
      end

      it { should be(true) }
    end

    describe 'that is greater than the allowed length range' do
      before do
        @value = 'a' * 51
      end

      it { should be(false) }
    end

    describe 'that is less than the allowed length range' do
      before do
        @value = ''
      end

      it { should be(false) }
    end
  end

  describe 'with a value that is not a string' do
    before do
      @value = 1
    end

    it { should be(false) }
  end
end
