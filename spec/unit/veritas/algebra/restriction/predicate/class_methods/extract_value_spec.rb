require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::Predicate.extract_value' do
  before do
    @header = Relation::Header.new([ [ :id, Integer ] ])
    @tuple  = Tuple.new(@header, [ 1 ])
  end

  subject { Algebra::Restriction::Predicate.extract_value(@operand, @tuple) }

  describe 'when the operand is an Attribute' do
    before do
      @operand = @header[:id]
    end

    it { should == 1 }
  end

  describe 'when the operand is not an Attribute' do
    before do
      @operand = mock('Value')
    end

    it { should equal(@operand) }
  end
end
