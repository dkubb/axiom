require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Proposition::False.eval' do
  subject { Logic::Proposition::False.eval }

  it { should be_false }
end
