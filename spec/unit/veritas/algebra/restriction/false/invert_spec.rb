require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::False#invert' do
  before do
    @false = Algebra::Restriction::False.instance
  end

  subject { @false.invert }

  it { should eql(Algebra::Restriction::True.instance) }

  it 'should invert back to original' do
    subject.invert.should eql(@false)
  end
end
