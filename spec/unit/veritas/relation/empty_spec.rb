require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#empty?' do
  let(:header) { [ [ :id, Integer ] ] }

  subject { relation.empty? }

  describe 'with a body containing no entries' do
    let(:relation) { Relation.new(header, []) }

    it { should be(true) }
  end

  describe 'with a body containing an entry' do
    let(:relation) { Relation.new(header, [ [ 1 ] ]) }

    it { should be(false) }
  end
end
