require 'spec_helper'

describe Logic::Proposition::True, '#or' do
  subject { object.or(other) }

  let(:klass)  { Logic::Proposition::True }
  let(:other)  { mock('other')            }
  let(:object) { klass.instance           }

  it { should equal(object) }
end
