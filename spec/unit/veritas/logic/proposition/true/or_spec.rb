require 'spec_helper'

describe Logic::Proposition::True, '#or' do
  subject { object.or(other) }

  let(:other)  { mock('other')            }
  let(:object) { described_class.instance }

  it { should equal(object) }
end
