require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute#valid_value?' do
  subject { @attribute.valid_value?(@value) }

  describe 'when value is nil' do
    before do
      @value = nil
    end

    describe 'and the attribute is required' do
      before do
        @attribute = Attribute::Integer.new(:id)
      end

      it { should be(false) }
    end

    describe 'and the attribute not required' do
      before do
        @attribute = Attribute::Integer.new(:id, :required => false)
      end

      it { should be(true) }
    end
  end

  describe 'when the value is a valid primitive' do
    before do
      @attribute = Attribute::Integer.new(:id)
      @value     = 1
    end

    it { should be(true) }
  end

  describe 'when the value is not a valid primitive' do
    before do
      @attribute = Attribute::Integer.new(:id)
      @value     = 'a'
    end

    it { should be(false) }
  end
end
