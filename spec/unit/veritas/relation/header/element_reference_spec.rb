require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Header#[]' do
  before do
    @header = Relation::Header.new([ [ :id, Integer ] ])
  end

  subject { @header[@name] }

  describe 'with a known attribute name' do
    before do
      @name = :id
    end

    it { should == [ :id, Integer ] }
  end

  describe 'with an unknown attribute name' do
    before do
      @name = :name
    end

    it { should be_nil }
  end
end
