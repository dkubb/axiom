require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Proposition::False#and' do
  subject { false_proposition.and(other) }

  let(:other)             { mock('other')                      }
  let(:false_proposition) { Logic::Proposition::False.instance }

  it { should equal(false_proposition) }
end
