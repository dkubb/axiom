require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::Disjunction#inspect' do
  before do
    @attribute = Attribute::Integer.new(:id)
    @left      = @attribute.gt(1)
    @right     = @attribute.lt(3)

    @disjunction = Algebra::Restriction::Disjunction.new(@left, @right)
  end

  subject { @disjunction.inspect }

  it { should == "(#{@left.inspect} OR #{@right.inspect})"}
end
