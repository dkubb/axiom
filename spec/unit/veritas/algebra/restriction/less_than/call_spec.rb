require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::LessThan#call' do
  before do
    @header    = Relation::Header.new([ [ :id, Integer ] ])
    @predicate = Algebra::Restriction::LessThan.new(@header[:id], 2)
  end

  subject { @predicate.call(@tuple) }

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
