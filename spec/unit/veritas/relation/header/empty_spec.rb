require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Header#empty?' do
  subject { @header.empty? }

  describe 'with attributes' do
    before do
      @header = Relation::Header.new([ [ :id, Integer ] ])
    end

    it { should be_false }
  end

  describe 'without attributes' do
    before do
      @header = Relation::Header.new
    end

    it { should be_true }
  end
end
