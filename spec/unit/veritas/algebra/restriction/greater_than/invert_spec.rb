require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::GreaterThan#invert' do
  before do
    @attribute = Attribute::Integer.new(:id)

    @greater_than = @attribute.gt(1)
  end

  subject { @greater_than.invert }

  it { should eql(@attribute.lte(1)) }

  it 'inverts back to original' do
    subject.invert.should eql(@greater_than)
  end
end
