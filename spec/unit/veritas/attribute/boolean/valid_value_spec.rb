require 'spec_helper'

describe 'Veritas::Attribute::Boolean#valid_value?' do
  subject { attribute.valid_value?(value) }

  let(:attribute) { Veritas::Attribute::Boolean.new(:boolean) }

  context 'with a true value' do
    let(:value) { true }

    it { should be(true) }
  end

  context 'with a false value' do
    let(:value) { false }

    it { should be(true) }
  end

  context 'with a value that is not true or false' do
    let(:value) { 1 }

    it { should be(false) }
  end
end
