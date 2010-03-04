require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::Negation#project' do
  before do
    @attribute  = Attribute::Integer.new(:id)
    @other      = Attribute::Integer.new(:other_id)
    @attributes = [ @attribute ]
  end

  subject { @negation.project(@attributes) }

  describe 'operand is removed' do
    before do
      @operand  = @other.eq(1)
      @negation = Algebra::Restriction::Negation.new(@operand)
    end

    it { should be_nil }
  end

  describe 'operand is not removed' do
    before do
      @operand  = @attribute.eq(1)
      @negation = Algebra::Restriction::Negation.new(@operand)
    end

    it { should equal(@negation) }
  end
end
