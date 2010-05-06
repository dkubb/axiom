require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute#valid_value?' do
  subject { attribute.valid_value?(value) }

  describe 'when value is nil' do
    let(:value) { nil }

    describe 'and the attribute is required' do
      let(:attribute) { Attribute::Integer.new(:id) }

      it { should be(false) }
    end

    describe 'and the attribute not required' do
      let(:attribute) { Attribute::Integer.new(:id, :required => false) }

      it { should be(true) }
    end
  end

  describe 'when the value is a valid primitive' do
    let(:attribute) { Attribute::Integer.new(:id) }
    let(:value)     { 1                           }

    it { should be(true) }
  end

  describe 'when the value is not a valid primitive' do
    let(:attribute) { Attribute::Integer.new(:id) }
    let(:value)     { 'a'                         }

    it { should be(false) }
  end
end
