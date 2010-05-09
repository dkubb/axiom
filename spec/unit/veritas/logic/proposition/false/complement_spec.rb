require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Proposition::False#complement' do
  subject { false_proposition.complement }

  let(:false_proposition) { Logic::Proposition::False.instance }

  it { should equal(Logic::Proposition::True.instance) }

  it 'is reversible' do
    subject.complement.should eql(false_proposition)
  end
end
