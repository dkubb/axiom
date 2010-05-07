require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Proposition::True#invert' do
  subject { true_proposition.invert }

  let(:true_proposition) { Logic::Proposition::True.instance }

  it { should equal(Logic::Proposition::False.instance) }

  it 'inverts back to original' do
    subject.invert.should eql(true_proposition)
  end
end
