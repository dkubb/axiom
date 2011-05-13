# encoding: utf-8

require 'spec_helper'

describe Relation::Header, '#empty?' do
  subject { object.empty? }


  context 'with attributes' do
    let(:object) { described_class.new([ [ :id, Integer ] ]) }

    it { should be(false) }
  end

  context 'without attributes' do
    let(:object) { described_class.new }

    it { should be(true) }
  end
end
