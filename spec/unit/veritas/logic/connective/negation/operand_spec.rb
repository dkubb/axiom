require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Connective::Negation#operand' do
  before do
    @attribute = Attribute::Integer.new(:id)
    @operand   = @attribute.eq(1)

    @negation = Logic::Connective::Negation.new(@operand)
  end

  subject { @negation.operand }

  it { should equal(@operand) }
end
