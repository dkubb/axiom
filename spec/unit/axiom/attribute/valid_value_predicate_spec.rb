# encoding: utf-8

require 'spec_helper'

describe Attribute, '#valid_value?' do
  subject { object.valid_value?(value) }

  let(:described_class) { Class.new(Attribute) }

  before do
    described_class.class_eval do
      def self.primitive
        ::Integer
      end
    end
  end

  context 'when value is nil' do
    let(:value) { nil }

    context 'and the attribute is required' do
      let(:object) { described_class.new(:name) }

      it { should be(false) }
    end

    context 'and the attribute not required' do
      let(:object) { described_class.new(:name, :required => false) }

      it { should be(true) }
    end
  end

  context 'when the value is a valid primitive' do
    let(:object) { described_class.new(:name) }
    let(:value)  { 1                          }

    it { should be(true) }
  end

  context 'when the value is not a valid primitive' do
    let(:object) { described_class.new(:name) }
    let(:value)  { 'a'                        }

    it { should be(false) }
  end
end
