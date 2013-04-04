# encoding: utf-8

require 'spec_helper'

describe Attribute, '#required?' do
  subject { object.required? }

  let(:described_class) { Class.new(Attribute) }

  context 'without :required option passed to constructor' do
    let(:object) { described_class.new(:name) }

    it { should be(true) }
  end

  context 'with :required => true option passed to constructor' do
    let(:object) { described_class.new(:name, :required => true) }

    it { should be(true) }
  end

  context 'with :required => false option passed to constructor' do
    let(:object) { described_class.new(:name, :required => false) }

    it { should be(false) }
  end
end
