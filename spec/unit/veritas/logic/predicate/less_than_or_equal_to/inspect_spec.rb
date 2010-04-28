require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Predicate::LessThanOrEqualTo#inspect' do
  before do
    @attribute = Attribute::Integer.new(:id)

    @less_than_or_equal_to = @attribute.lte(1)
  end

  subject { @less_than_or_equal_to.inspect }

  it { should == "#{@attribute.inspect} <= 1" }
end
