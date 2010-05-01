require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute::Numeric#valid_value?' do
  before do
    @attribute = Veritas::Attribute::Numeric.new(:numeric, :size => 1..50)
  end

  subject { @attribute.valid_value?(@value) }

  describe 'with a numeric value' do
    describe 'that is within the allowed size range' do
      before do
        @value = 1
      end

      it { should be(true) }
    end

    describe 'that is greater than the allowed size range' do
      before do
        @value = 51
      end

      it { should be(false) }
    end

    describe 'that is less than the allowed size range' do
      before do
        @value = 0
      end

      it { should be(false) }
    end
  end

  describe 'with a value that is not a numeric' do
    before do
      @value = 'a'
    end

    it { should be(false) }
  end
end
