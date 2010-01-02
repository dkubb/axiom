require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Header#values_at' do
  before do
    @header = Relation::Header.new([ [ :id, Integer ] ])
  end

  subject { @header.values_at(*@attributes) }

  describe 'with a known attribute name' do
    before do
      @attributes = [ :id ]
    end

    it { should be_kind_of(Array) }

    it { should == [ [ :id, Integer ] ] }
  end

  describe 'with an unknown attribute name' do
    before do
      @attributes = [ :name ]
    end

    it { should be_kind_of(Array) }

    it { should == [ nil ] }
  end

  describe 'with a known and unknown attribute name' do
    before do
      @attributes = [ :id, :name ]
    end

    it { should be_kind_of(Array) }

    it { should == [ [ :id, Integer ], nil ] }
  end
end
