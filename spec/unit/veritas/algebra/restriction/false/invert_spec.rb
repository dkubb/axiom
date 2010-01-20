require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::False#invert' do
  before do
    @false = Algebra::Restriction::False.new
  end

  subject { @false.invert }

  it { should eql(Algebra::Restriction::True.new) }

  it 'should invert back to original' do
    subject.invert.should eql(@false)
  end
end
