require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Proposition::True#and' do
  let(:other)            { mock('other')                     }
  let(:true_proposition) { Logic::Proposition::True.instance }

  subject { true_proposition.and(other) }

  it { should equal(other) }
end
