require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Proposition::False#or' do
  let(:other)             { mock('other')                      }
  let(:false_proposition) { Logic::Proposition::False.instance }

  subject { false_proposition.or(other) }

  it { should equal(other) }
end
