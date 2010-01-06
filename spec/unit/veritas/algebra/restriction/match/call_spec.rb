require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::Match#call' do
  before do
    @header    = Relation::Header.new([ [ :name, String ] ])
    @predicate = Algebra::Restriction::Match.new(@header[:name], /Dan Kubb/)
  end

  subject { @predicate.call(@tuple) }

  describe 'with a tuple that matches' do
    before do
      @tuple = Tuple.new(@header, [ 'Dan Kubb' ])
    end

    it { should be_true }
  end

  describe 'with a tuple that does not match' do
    before do
      @tuple = Tuple.new(@header, [ 'Alex Kubb' ])
    end

    it { should be_false }
  end
end
