require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::Equality#inspect' do
  before do
    @attribute = Attribute::Integer.new(:id)

    @equality = @attribute.eq(1)
  end

  subject { @equality.inspect }

  it { should == "#{@attribute.inspect} == 1" }
end
