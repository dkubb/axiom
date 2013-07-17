# encoding: utf-8

require 'spec_helper'

describe Attribute::String, '#valid_value?' do
  subject { object.valid_value?(value) }

  let(:object) { described_class.new(:string, min_length: 1, max_length: 50) }

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
