require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Proposition::False#and' do
  let(:other)             { mock('other')                      }
  let(:false_proposition) { Logic::Proposition::False.instance }

  subject { false_proposition.and(other) }

  it { should equal(false_proposition) }
end
