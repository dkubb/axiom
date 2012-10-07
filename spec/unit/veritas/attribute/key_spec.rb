# encoding: utf-8

require 'spec_helper'

describe Attribute, '#key?' do
  subject { object.key? }

  let(:described_class) { Class.new(Attribute) }

  context 'without :key option passed to constructor' do
    let(:object) { described_class.new(:name) }

    it { should be(false) }
  end

  context 'with :key => true option passed to constructor' do
    let(:object) { described_class.new(:name, :key => true) }

    it { should be(true) }
  end

  context 'with :key => false option passed to constructor' do
    let(:object) { described_class.new(:name, :key => false) }

    it { should be(false) }
  end
end
