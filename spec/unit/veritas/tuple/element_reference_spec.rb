require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Tuple#[]' do
  before do
    @header = Relation::Header.new([ [ :id, Integer ] ])
    @tuple  = Tuple.new(@header, [ 1 ])
  end

  subject { @tuple[@attribute] }

  describe 'with a known attribute' do
    before do
      @attribute = @header[:id]
    end

    it { should == 1 }
  end

  describe 'with an known attribute' do
    before do
      @attribute = Attribute::Integer.new(:other_id)
    end

    it { should be_nil }
  end
end
