require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Header#empty?' do
  subject { header.empty? }

  describe 'with attributes' do
    let(:header) { Relation::Header.new([ [ :id, Integer ] ]) }

    it { should be(false) }
  end

  describe 'without attributes' do
    let(:header) { Relation::Header.new }

    it { should be(true) }
  end
end
