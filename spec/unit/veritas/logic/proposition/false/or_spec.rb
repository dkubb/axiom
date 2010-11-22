require 'spec_helper'

describe 'Veritas::Logic::Proposition::False#or' do
  subject { object.or(other) }

  let(:klass)  { Logic::Proposition::False }
  let(:other)  { mock('other')             }
  let(:object) { klass.instance            }

  it { should equal(other) }
end
