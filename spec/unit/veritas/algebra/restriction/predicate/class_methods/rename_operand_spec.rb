require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::Predicate.rename_operand' do
  before do
    @attribute = Attribute::Integer.new(:id)
    @other     = Attribute::Integer.new(:other_id)
    @aliases   = { :id => :other_id }
  end

  subject { Algebra::Restriction::Predicate.rename_operand(@operand, @aliases) }

  describe 'when the operand responds to #rename' do
    before do
      @operand = @attribute
    end

    it { should eql(Attribute::Integer.new(:other_id)) }
  end

  describe 'when the operand does not respond to #rename' do
    before do
      @operand = @other
    end

    it { should equal(@operand) }
  end
end
