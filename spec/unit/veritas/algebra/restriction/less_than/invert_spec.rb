require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::LessThan#invert' do
  before do
    @attribute = Attribute::Integer.new(:id)

    @less_than = @attribute.lt(1)
  end

  subject { @less_than.invert }

  it { should eql(@attribute.gte(1)) }

  it 'should invert back to original' do
    subject.invert.should eql(@less_than)
  end
end
