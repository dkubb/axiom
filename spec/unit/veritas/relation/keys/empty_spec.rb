# encoding: utf-8

require 'spec_helper'

describe Relation::Keys, '#empty?' do
  subject { object.empty? }

  let(:object) { described_class.coerce(keys) }

  context 'with keys' do
    let(:keys) { [ [ [ :id ] ] ] }

    it { should be(false) }
  end

  context 'without keys' do
    let(:keys) { [] }

    it { should be(true) }
  end
end
