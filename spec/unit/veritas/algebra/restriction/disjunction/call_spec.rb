require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::Disjunction#call' do
  before do
    @header = Relation::Header.new([ [ :id, Integer ] ])
    @left   = Algebra::Restriction::Equality.new(@header[:id], 1)
    @right  = Algebra::Restriction::Equality.new(@header[:id], 2)

    @conjunction = Algebra::Restriction::Disjunction.new(@left, @right)
  end

  subject { @conjunction.call(@tuple) }

  describe 'with a tuple that matches' do
    before do
      @tuple = Tuple.new(@header, [ 2 ])
    end

    it { should be_true }
  end

  describe 'with a tuple that does not match' do
    before do
      @tuple = Tuple.new(@header, [ 3 ])
    end

    it { should be_false }
  end
end
