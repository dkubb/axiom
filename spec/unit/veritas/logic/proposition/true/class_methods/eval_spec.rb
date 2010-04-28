require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Proposition::True.eval' do
  subject { Logic::Proposition::True.eval }

  it { should be_true }
end
