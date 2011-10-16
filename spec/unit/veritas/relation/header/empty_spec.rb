# encoding: utf-8

require 'spec_helper'

describe Relation::Header, '#empty?' do
  subject { object.empty? }

  let(:object) { described_class.new(entries) }

  context 'with entries' do
    let(:entries) { [ [ :id, Integer ] ] }

    it { should be(false) }
  end

  context 'without entries' do
    let(:entries) { [] }

    it { should be(true) }
  end
end
