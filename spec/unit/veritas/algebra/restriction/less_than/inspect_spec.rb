require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::LessThan#inspect' do
  before do
    @attribute = Attribute::Integer.new(:id)

    @less_than = @attribute.lt(1)
  end

  subject { @less_than.inspect }

  it { should == "#{@attribute.inspect} < 1" }
end
