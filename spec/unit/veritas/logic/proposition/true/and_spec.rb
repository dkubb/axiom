require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Proposition::True#and' do
  subject { true_proposition.and(other) }

  let(:other)            { mock('other')                     }
  let(:true_proposition) { Logic::Proposition::True.instance }

  it { should equal(other) }
end
