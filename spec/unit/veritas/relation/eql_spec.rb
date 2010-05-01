require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#eql?' do
  before do
    @header = [ [ :id, Integer ] ]
    @tuples = [ [ 1 ] ]

    @relation = Relation.new(@header, @tuples)
  end

  subject { @relation.eql?(@other) }

  describe 'with the same relation' do
    before do
      @other = @relation
    end

    it { should be(true) }

    it 'is symmetric' do
      should == @other.eql?(@relation)
    end
  end

  describe 'with an equivalent relation' do
    before do
      @other = @relation.dup
    end

    it { should be(true) }

    it 'is symmetric' do
      should == @other.eql?(@relation)
    end
  end

  describe 'with a different relation' do
    before do
      @other = Relation.new(@header, [ [ 2 ] ])
    end

    it { should be(false) }

    it 'is symmetric' do
      should == @other.eql?(@relation)
    end
  end

  describe 'with an equivalent relation of a different class' do
    before do
      klass = Class.new(Relation)

      @other = klass.new(@header, @tuples)
    end

    it { should be(false) }

    it 'is symmetric' do
      should == @other.eql?(@relation)
    end
  end
end
