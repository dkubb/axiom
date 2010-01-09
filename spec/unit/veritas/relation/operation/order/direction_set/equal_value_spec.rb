require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order::DirectionSet#==' do
  before do
    @attribute  = Attribute::Integer.new(:id)
    @directions = Relation::Operation::Order::DirectionSet.new([ @attribute ])
  end

  subject { @directions == @other }

  describe 'with the same direction' do
    before do
      @other = @directions
    end

    it { should be_true }

    it 'should be symmetric' do
      should == (@other == @directions)
    end
  end

  describe 'with an equivalent directions' do
    before do
      @other = @directions.dup
    end

    it { should be_true }

    it 'should be symmetric' do
      should == (@other == @directions)
    end
  end

  describe 'with a different directions' do
    before do
      @attribute = Attribute::Integer.new(:name)
      @other     = Relation::Operation::Order::DirectionSet.new([ @attribute ])
    end

    it { should be_false }

    it 'should be symmetric' do
      should == (@other == @directions)
    end
  end

  describe 'with an equivalent directions of a different class' do
    before do
      klass = Class.new(Relation::Operation::Order::DirectionSet)

      @other = klass.new([ @attribute ])
    end

    it { should be_true }

    it 'should be symmetric' do
      should == (@other == @directions)
    end
  end
end
