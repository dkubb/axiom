require 'spec_helper'

describe 'Veritas::Logic::Proposition::False.eval' do
  subject { Logic::Proposition::False.eval }

  it { should be(false) }
end
