# encoding: utf-8

require 'spec_helper'

describe Attribute::Numeric, '#valid_value?' do
  subject { object.valid_value?(value) }

  let(:object) { described_class.new(:numeric, size: 1..50) }

  context 'with a numeric value' do
    context 'that is within the allowed size range' do
      let(:value) { 1 }

      it { should be(true) }
    end

    context 'that is greater than the allowed size range' do
      let(:value) { 51 }

      it { should be(false) }
    end

    context 'that is less than the allowed size range' do
      let(:value) { 0 }

      it { should be(false) }
    end
  end

  context 'with a value that is not a numeric' do
    let(:value) { 'a' }

    it { should be(false) }
  end
end
