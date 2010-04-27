require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::GreaterThanOrEqualTo#invert' do
  before do
    @attribute = Attribute::Integer.new(:id)

    @greater_than_or_equal_to = @attribute.gte(1)
  end

  subject { @greater_than_or_equal_to.invert }

  it { should eql(@attribute.lt(1)) }

  it 'inverts back to original' do
    subject.invert.should eql(@greater_than_or_equal_to)
  end
end
