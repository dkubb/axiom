require File.expand_path('../../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Algebra::Restriction::Proposition#eql?' do
  before do
    @proposition = PropositionSpecs::Object.new
  end

  subject { @proposition.eql?(@other) }

  describe 'with the same class' do
    before do
      @other = PropositionSpecs::Object.new
    end

    it { should be_true }

    it 'should be symmetric' do
      should == @other.eql?(@proposition)
    end
  end

  describe 'with a different class' do
    before do
      @other = Class.new(Algebra::Restriction::Proposition).new
    end

    it { should be_false }

    it 'should be symmetric' do
      should == @other.eql?(@proposition)
    end
  end
end
