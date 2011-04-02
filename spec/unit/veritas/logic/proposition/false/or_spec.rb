require 'spec_helper'

describe Logic::Proposition::False, '#or' do
  subject { object.or(other) }

  let(:other)  { mock('other')            }
  let(:object) { described_class.instance }

  it { should equal(other) }
end
