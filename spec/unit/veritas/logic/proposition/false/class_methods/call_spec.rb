require 'spec_helper'

describe 'Veritas::Logic::Proposition::False.call' do
  subject { Logic::Proposition::False.call }

  it { should be(false) }
end
