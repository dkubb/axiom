require 'spec_helper'

describe 'Veritas::Logic::Proposition::False#and' do
  subject { object.and(other) }

  let(:klass)  { Logic::Proposition::False }
  let(:other)  { mock('other')             }
  let(:object) { klass.instance            }

  it { should equal(object) }
end
