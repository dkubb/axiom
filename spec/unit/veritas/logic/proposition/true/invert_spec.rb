require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Proposition::True#invert' do
  before do
    @true = Logic::Proposition::True.instance
  end

  subject { @true.invert }

  it { should equal(Logic::Proposition::False.instance) }

  it 'inverts back to original' do
    subject.invert.should eql(@true)
  end
end
