require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::Conjunction#call' do
  before do
    @header = Relation::Header.new([ [ :id, Integer ] ])
    @left   = Algebra::Restriction::Equality.new(@header[:id], 1)
    @right  = Algebra::Restriction::Inequality.new(@header[:id], 2)

    @conjunction = Algebra::Restriction::Conjunction.new(@left, @right)
  end

  subject { @conjunction.call(@tuple) }

  describe 'with a tuple that matches' do
    before do
      @tuple = Tuple.new(@header, [ 1 ])
    end

    it { should be_true }
  end

  describe 'with a tuple that does not match' do
    before do
      @tuple = Tuple.new(@header, [ 2 ])
    end

    it { should be_false }
  end
end
