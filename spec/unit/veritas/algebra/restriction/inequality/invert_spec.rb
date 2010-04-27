require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::Inequality#invert' do
  before do
    @attribute = Attribute::Integer.new(:id)

    @inequality = @attribute.ne(1)
  end

  subject { @inequality.invert }

  it { should eql(@attribute.eq(1)) }

  it 'inverts back to original' do
    subject.invert.should eql(@inequality)
  end
end
