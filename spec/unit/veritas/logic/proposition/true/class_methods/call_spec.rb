require 'spec_helper'

describe 'Veritas::Logic::Proposition::True.call' do
  subject { Logic::Proposition::True.call }

  it { should be(true) }
end
