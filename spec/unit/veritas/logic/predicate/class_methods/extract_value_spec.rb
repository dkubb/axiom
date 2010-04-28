require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Predicate.extract_value' do
  before do
    @header = Relation::Header.new([ [ :id, Integer ] ])
    @tuple  = Tuple.new(@header, [ 1 ])
  end

  subject { Logic::Predicate.extract_value(@operand, @tuple) }

  describe 'when the operand responds to #call' do
    before do
      @operand = @header[:id]
    end

    it { should == 1 }
  end

  describe 'when the operand does not respond to #call' do
    before do
      @operand = mock('Value')
    end

    it { should equal(@operand) }
  end
end
