require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Proposition::False#invert' do
  let(:false_proposition) { Logic::Proposition::False.instance }

  subject { false_proposition.invert }

  it { should equal(Logic::Proposition::True.instance) }

  it 'inverts back to original' do
    subject.invert.should eql(false_proposition)
  end
end
