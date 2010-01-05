require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Tuple#values_at' do
  before do
    @tuple = Relation::Header.new([ [ :id, Integer ] ])
    @tuple = Tuple.new(@tuple, [ 1 ])
  end

  subject { @tuple.values_at(*@indexes) }

  describe 'with a known index' do
    before do
      @indexes = [ 0 ]
    end

    it { should be_kind_of(Array) }

    it { should == [ 1 ] }
  end

  describe 'with an unknown index name' do
    before do
      @indexes = [ 1 ]
    end

    it { should be_kind_of(Array) }

    it { should == [ nil ] }
  end

  describe 'with a known and unknown index' do
    before do
      @indexes = [ 0, 1 ]
    end

    it { should be_kind_of(Array) }

    it { should == [ 1, nil ] }
  end
end
