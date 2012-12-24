# encoding: utf-8

require 'spec_helper'

describe Relation::Keys, '#empty?' do
  subject { object.empty? }

  let(:object) { described_class.new(keys) }

  context 'with keys' do
    let(:keys) { [ Relation::Header.coerce([ [ :id ] ]) ] }

    it { should be(false) }
  end

  context 'without keys' do
    let(:keys) { [] }

    it { should be(true) }
  end
end
