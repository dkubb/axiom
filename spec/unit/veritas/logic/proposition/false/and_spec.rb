require 'spec_helper'

describe Logic::Proposition::False, '#and' do
  subject { object.and(other) }

  let(:other)  { mock('other')            }
  let(:object) { described_class.instance }

  it { should equal(object) }
end
