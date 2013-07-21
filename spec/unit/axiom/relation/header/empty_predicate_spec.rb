# encoding: utf-8

require 'spec_helper'

describe Relation::Header, '#empty?' do
  subject { object.empty? }

  let(:object) { described_class.new(attributes) }

  context 'with attributes' do
    let(:attributes) { [Attribute::Integer.new(:id)] }

    it { should be(false) }
  end

  context 'without attributes' do
    let(:attributes) { [] }

    it { should be(true) }
  end
end
