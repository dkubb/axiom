require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Connective::Disjunction#inspect' do
  before do
    @attribute = Attribute::Integer.new(:id)
    @left      = @attribute.gt(1)
    @right     = @attribute.lt(3)

    @disjunction = Logic::Connective::Disjunction.new(@left, @right)
  end

  subject { @disjunction.inspect }

  it { should == "(#{@left.inspect} OR #{@right.inspect})"}
end
