require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::Predicate#eql?' do
  before do
    @header = Relation::Header.new([ [ :id, Integer ], [ :name, String ] ])
    @klass  = Class.new(Algebra::Restriction::Predicate)

    # Predicate is an abstract class, so call constructor on anonymous subclass
    @predicate = @klass.new(@header[:id], 1)
  end

  subject { @predicate.eql?(@other) }

  describe 'with the same predicate' do
    before do
      @other = @predicate
    end

    it { should be_true }

    it 'should be symmetric' do
      should == @other.eql?(@predicate)
    end
  end

  describe 'with an equivalent predicate' do
    before do
      @other = @predicate.dup
    end

    it { should be_true }

    it 'should be symmetric' do
      should == @other.eql?(@predicate)
    end
  end

  describe 'with a different predicate' do
    before do
      @other = @klass.new(@header[:name], 1)
    end

    it { should be_false }

    it 'should be symmetric' do
      should == @other.eql?(@predicate)
    end
  end

  describe 'with an equivalent predicate of a different class' do
    before do
      klass = Class.new(@klass)

      @other = klass.new(@header[:id], 1)
    end

    it { should be_false }

    it 'should be symmetric' do
      should == @other.eql?(@predicate)
    end
  end
end
