require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::Conjunction#inspect' do
  before do
    @attribute = Attribute::Integer.new(:id)
    @left      = @attribute.gt(1)
    @right     = @attribute.lt(3)

    @conjunction = Algebra::Restriction::Conjunction.new(@left, @right)
  end

  subject { @conjunction.inspect }

  it { should == "(#{@left.inspect} AND #{@right.inspect})"}
end
