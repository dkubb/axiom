require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Connective::Negation#inspect' do
  before do
    @attribute = Attribute::Integer.new(:id)
    @operand   = @attribute.eq(1)

    @negation = Logic::Connective::Negation.new(@operand)
  end

  subject { @negation.inspect }

  it { should == "NOT(#{@operand.inspect})" }
end
