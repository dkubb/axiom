require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#empty?' do
  before do
    @header = Relation::Header.new([ [ :id, Integer ] ])
  end

  subject { @body.empty? }

  describe 'with a body containing no entries' do
    before do
      @body = Relation::Body.new(@header, [])
    end

    it { should be_true }
  end

  describe 'with a body containing an entry' do
    before do
      @body = Relation::Body.new(@header, [ [ 1 ] ])
    end

    it { should be_false }
  end
end
