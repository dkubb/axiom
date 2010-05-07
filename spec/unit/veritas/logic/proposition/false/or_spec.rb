require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Proposition::False#or' do
  subject { false_proposition.or(other) }

  let(:other)             { mock('other')                      }
  let(:false_proposition) { Logic::Proposition::False.instance }

  it { should equal(other) }
end
