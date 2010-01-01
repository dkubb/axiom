require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Header#==' do
  before do
    @attribute = [ :id, Integer ]

    @header = Relation::Header.new([ @attribute ])
  end

  subject { @header == @other }

  describe 'with equivalent header' do
    before do
      @other = @header.dup
    end

    it { should be_true }
  end

  describe 'with different header' do
    before do
      @other = Relation::Header.new([ [ :name, String ] ])
    end

    it { should be_false }
  end

  describe 'with an equivalent object responding to #to_ary' do
    before do
      @other = [ @attribute ]
    end

    it { should be_true }
  end

  describe 'with a different object responding to #to_ary' do
    before do
      @other = [ [ :name, String ] ]
    end

    it { should be_false }
  end

  describe 'with equivalent attributes in a different order' do
    before do
      @attribute1 = [ :id,   Integer ]
      @attribute2 = [ :name, String  ]

      @header = Relation::Header.new([ @attribute1, @attribute2 ])
      @other  = Relation::Header.new([ @attribute2, @attribute1 ])
    end

    it { should be_true }
  end
end
