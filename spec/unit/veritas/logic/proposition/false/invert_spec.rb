require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Proposition::False#invert' do
  before do
    @false = Logic::Proposition::False.instance
  end

  subject { @false.invert }

  it { should equal(Logic::Proposition::True.instance) }

  it 'inverts back to original' do
    subject.invert.should eql(@false)
  end
end
