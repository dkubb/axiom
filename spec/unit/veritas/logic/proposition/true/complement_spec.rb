require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Proposition::True#complement' do
  subject { true_proposition.complement }

  let(:true_proposition) { Logic::Proposition::True.instance }

  it { should equal(Logic::Proposition::False.instance) }

  it 'is reversible' do
    subject.complement.should eql(true_proposition)
  end
end
