# encoding: utf-8

require 'spec_helper'

describe Attribute, '#required?' do
  subject { object.required? }

  let(:described_class) { Attribute::Integer }

  context 'without :required option passed to constructor' do
    let(:object) { described_class.new(:id) }

    it { should be(true) }
  end

  context 'with :required => true option passed to constructor' do
    let(:object) { described_class.new(:id, :required => true) }

    it { should be(true) }
  end

  context 'with :required => false option passed to constructor' do
    let(:object) { described_class.new(:id, :required => false) }

    it { should be(false) }
  end
end
