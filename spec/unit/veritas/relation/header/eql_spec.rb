require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Header#eql?' do
  before do
    @attribute = [ :id, Integer ]

    @header = Relation::Header.new([ @attribute ])
  end

  subject { @header.eql?(@other) }

  describe 'with equivalent attributes' do
    before do
      @other = @header.dup
    end

    it { should be_true }
  end

  describe 'with different attributes' do
    before do
      @other = Relation::Header.new([ [ :name, String ] ])
    end

    it { should be_false }
  end

  describe 'with an equivalent header of different classes' do
    before do
      klass = Class.new(Relation::Header)

      @other = klass.new([ @attribute ])
    end

    it { should be_false }

    it 'should otherwise be equivalent' do
      @header.should == @other
    end
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
