require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Header#eql?' do
  before do
    @attribute = [ :id, Integer ]

    @header = Relation::Header.new([ @attribute ])
  end

  subject { @header.eql?(@other) }

  describe 'with the same header' do
    before do
      @other = @header
    end

    it { should be_true }

    it 'is symmetric' do
      should == @other.eql?(@header)
    end
  end

  describe 'with an equivalent header' do
    before do
      @other = @header.dup
    end

    it { should be_true }

    it 'is symmetric' do
      should == @other.eql?(@header)
    end
  end

  describe 'with a different header' do
    before do
      @other = Relation::Header.new([ [ :name, String ] ])
    end

    it { should be_false }

    it 'is symmetric' do
      should == @other.eql?(@header)
    end
  end

  describe 'with an equivalent header of different classes' do
    before do
      klass = Class.new(Relation::Header)

      @other = klass.new([ @attribute ])
    end

    it { should be_false }

    it 'is symmetric' do
      should == @other.eql?(@header)
    end
  end

  describe 'with an equivalent object responding to #to_ary' do
    before do
      @other = [ @attribute ]
    end

    it { should be_false }

    specification = proc do
      should == @other.eql?(@header)
    end

    it 'is symmetric' do
      if RUBY_PLATFORM[/java/]
        pending('Array#eql? does not call other#to_ary in JRuby', &specification)
      else
        instance_eval(&specification)
      end
    end
  end

  describe 'with a different object responding to #to_ary' do
    before do
      @other = [ [ :name, String ] ]
    end

    it { should be_false }

    it 'is symmetric' do
      should == @other.eql?(@header)
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

    it 'is symmetric' do
      should == @other.eql?(@header)
    end
  end
end
