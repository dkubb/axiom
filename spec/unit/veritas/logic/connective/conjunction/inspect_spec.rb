require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Connective::Conjunction#inspect' do
  before do
    @attribute = Attribute::Integer.new(:id)
    @left      = @attribute.gt(1)
    @right     = @attribute.lt(3)

    @conjunction = Logic::Connective::Conjunction.new(@left, @right)
  end

  subject { @conjunction.inspect }

  it { should == "(#{@left.inspect} AND #{@right.inspect})"}
end
