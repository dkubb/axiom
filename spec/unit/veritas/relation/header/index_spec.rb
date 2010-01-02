require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Header#index' do
  before do
    @attribute = [ :id, Integer ]
    @header    = Relation::Header.new([ @attribute ])
  end

  subject { @header.index(@object) }

  describe 'with a known attribute' do
    before do
      @object = @attribute
    end

    it { should == 0 }
  end

  describe 'with an unknown attribute' do
    before do
      @object = [ :name, String ]
    end

    it { should be_nil }
  end
end
