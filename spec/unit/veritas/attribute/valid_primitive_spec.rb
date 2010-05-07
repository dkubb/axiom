require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute#valid_primitive?' do
  subject { attribute.valid_primitive?(value) }

  let(:attribute) { Attribute::Integer.new(:id) }

  context 'with a valid value' do
    let(:value) { 1 }

    it { should be(true) }
  end

  context 'with an invalid value' do
    let(:value) { 'a' }

    it { should be(false) }
  end
end
