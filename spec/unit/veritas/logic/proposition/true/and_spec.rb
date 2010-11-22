require 'spec_helper'

describe 'Veritas::Logic::Proposition::True#and' do
  subject { object.and(other) }

  let(:klass)  { Logic::Proposition::True }
  let(:other)  { mock('other')            }
  let(:object) { klass.instance           }

  it { should equal(other) }
end
