require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::GreaterThan#inspect' do
  before do
    @attribute = Attribute::Integer.new(:id)

    @greater_than = @attribute.gt(1)
  end

  subject { @greater_than.inspect }

  it { should == "#{@attribute.inspect} > 1" }
end
