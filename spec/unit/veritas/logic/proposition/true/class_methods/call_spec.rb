require 'spec_helper'

describe 'Veritas::Logic::Proposition::True.call' do
  subject { object.call }

  let(:object) { Logic::Proposition::True }

  it { should be(true) }
end
