require File.expand_path('../../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Algebra::Restriction::BinaryConnective#eql?' do
  before do
    @header = Relation::Header.new([ [ :id, Integer ], [ :name, String ] ])
    @left   = Algebra::Restriction::Equality.new(@header[:id], 1)
    @right  = Algebra::Restriction::Equality.new(@header[:id], 2)

    @connective = BinaryConnectiveSpecs::Object.new(@left, @right)
  end

  subject { @connective.eql?(@other) }

  describe 'with the same connective' do
    before do
      @other = @connective
    end

    it { should be_true }

    it 'should be symmetric' do
      should == @other.eql?(@connective)
    end
  end

  describe 'with an equivalent connective' do
    before do
      @other = @connective.dup
    end

    it { should be_true }

    it 'should be symmetric' do
      should == @other.eql?(@connective)
    end
  end

  describe 'with a different connective' do
    before do
      @other = BinaryConnectiveSpecs::Object.new(@header[:name], 1)
    end

    it { should be_false }

    it 'should be symmetric' do
      should == @other.eql?(@connective)
    end
  end

  describe 'with an equivalent connective of a different class' do
    before do
      klass = Class.new(BinaryConnectiveSpecs::Object)

      @other = klass.new(@header[:id], 1)
    end

    it { should be_false }

    it 'should be symmetric' do
      should == @other.eql?(@connective)
    end
  end
end
