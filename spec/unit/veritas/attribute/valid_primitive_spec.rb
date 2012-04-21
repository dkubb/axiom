# encoding: utf-8

require 'spec_helper'

describe Attribute, '#valid_primitive?' do
  subject { object.valid_primitive?(value) }

  let(:described_class) { Class.new(Attribute)       }
  let(:object)          { described_class.new(:name) }

  before do
    described_class.class_eval do
      def self.primitive
        ::Integer
      end
    end
  end

  context 'with a valid value' do
    let(:value) { 1 }

    it { should be(true) }
  end

  context 'with an invalid value' do
    let(:value) { 'a' }

    it { should be(false) }
  end
end
