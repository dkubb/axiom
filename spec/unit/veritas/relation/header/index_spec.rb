require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Header#index' do
  before do
    @attribute = mock('Attribute')
    @header    = Relation::Header.new([ @attribute ])
  end

  subject { @header.index(@object) }

  describe 'with valid index' do
    before do
      @object = @attribute
    end

    it { should == 0 }
  end

  describe 'with invalid index' do
    before do
      @object = mock('Different Attribute')
    end

    it { should be_nil }
  end
end
