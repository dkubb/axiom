require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Proposition::True#invert' do
  let(:true_proposition) { Logic::Proposition::True.instance }

  subject { true_proposition.invert }

  it { should equal(Logic::Proposition::False.instance) }

  it 'inverts back to original' do
    subject.invert.should eql(true_proposition)
  end
end
