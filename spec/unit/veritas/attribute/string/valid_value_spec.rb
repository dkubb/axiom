require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute::String#valid_value?' do
  let(:attribute) { Veritas::Attribute::String.new(:string, :length => 1..50) }

  subject { attribute.valid_value?(value) }

  context 'with a string value' do
    context 'that is within the allowed length range' do
      let(:value) { 'a' }

      it { should be(true) }
    end

    context 'that is greater than the allowed length range' do
      let(:value) { 'a' * 51 }

      it { should be(false) }
    end

    context 'that is less than the allowed length range' do
      let(:value) { '' }

      it { should be(false) }
    end
  end

  context 'with a value that is not a string' do
    let(:value) { 1 }

    it { should be(false) }
  end
end
