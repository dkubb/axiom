require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::True#invert' do
  before do
    @true = Algebra::Restriction::True.instance
  end

  subject { @true.invert }

  it { should eql(Algebra::Restriction::False.instance) }

  it 'should invert back to original' do
    subject.invert.should eql(@true)
  end
end
