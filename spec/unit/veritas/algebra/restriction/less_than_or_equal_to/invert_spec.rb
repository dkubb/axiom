require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::LessThanOrEqualTo#invert' do
  before do
    @attribute = Attribute::Integer.new(:id)

    @less_than_or_equal_to = @attribute.lte(1)
  end

  subject { @less_than_or_equal_to.invert }

  it { should eql(@attribute.gt(1)) }

  it 'inverts back to original' do
    subject.invert.should eql(@less_than_or_equal_to)
  end
end
