require 'spec_helper'

describe 'Veritas::Relation::Header#empty?' do
  subject { header.empty? }

  context 'with attributes' do
    let(:header) { Relation::Header.new([ [ :id, Integer ] ]) }

    it { should be(false) }
  end

  context 'without attributes' do
    let(:header) { Relation::Header.new }

    it { should be(true) }
  end
end
