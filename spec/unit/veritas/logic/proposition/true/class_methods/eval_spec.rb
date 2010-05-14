require 'spec_helper'

describe 'Veritas::Logic::Proposition::True.eval' do
  subject { Logic::Proposition::True.eval }

  it { should be(true) }
end
