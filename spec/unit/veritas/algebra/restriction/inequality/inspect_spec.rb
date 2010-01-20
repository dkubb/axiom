require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::Inequality#inspect' do
  before do
    @attribute = Attribute::Integer.new(:id)

    @inequality = @attribute.ne(1)
  end

  subject { @inequality.inspect }

  it { should == "#{@attribute.inspect} != 1" }
end
