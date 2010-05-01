require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#empty?' do
  before do
    @header = [ [ :id, Integer ] ]
  end

  subject { @relation.empty? }

  describe 'with a body containing no entries' do
    before do
      @relation = Relation.new(@header, [])
    end

    it { should be(true) }
  end

  describe 'with a body containing an entry' do
    before do
      @relation = Relation.new(@header, [ [ 1 ] ])
    end

    it { should be(false) }
  end
end
