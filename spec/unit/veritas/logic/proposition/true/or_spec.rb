require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Proposition::True#or' do
  subject { true_proposition.or(other) }

  let(:other)            { mock('other')                     }
  let(:true_proposition) { Logic::Proposition::True.instance }

  it { should equal(true_proposition) }
end
