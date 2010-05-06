require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Proposition::True#or' do
  let(:other)            { mock('other')                     }
  let(:true_proposition) { Logic::Proposition::True.instance }

  subject { true_proposition.or(other) }

  it { should equal(true_proposition) }
end
