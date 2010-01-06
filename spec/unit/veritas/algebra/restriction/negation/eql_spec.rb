require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::Negation#eql?' do
  before do
    @header    = Relation::Header.new([ [ :id, Integer ], [ :name, String ] ])
    @predicate = Algebra::Restriction::Equality.new(@header[:id], 1)

    @negation = Algebra::Restriction::Negation.new(@predicate)
  end

  subject { @negation.eql?(@other) }

  describe 'with the same negation' do
    before do
      @other = @negation
    end

    it { should be_true }

    it 'should be symmetric' do
      should == @other.eql?(@negation)
    end
  end

  describe 'with an equivalent negation' do
    before do
      @other = @negation.dup
    end

    it { should be_true }

    it 'should be symmetric' do
      should == @other.eql?(@negation)
    end
  end

  describe 'with a different negation' do
    before do
      @predicate = Algebra::Restriction::Equality.new(@header[:name], 'Dan Kubb')
      @other     = Algebra::Restriction::Negation.new(@predicate)
    end

    it { should be_false }

    it 'should be symmetric' do
      should == @other.eql?(@negation)
    end
  end

  describe 'with an equivalent negation of a different class' do
    before do
      klass = Class.new(Algebra::Restriction::Negation)

      @other = klass.new(@predicate)
    end

    it { should be_false }

    it 'should be symmetric' do
      should == @other.eql?(@negation)
    end
  end

end
