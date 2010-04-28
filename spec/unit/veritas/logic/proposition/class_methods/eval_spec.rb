require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Proposition.eval' do
  subject { Logic::Proposition.eval }

  it { method(:subject).should raise_error(NotImplementedError, 'Veritas::Logic::Proposition.eval must be implemented') }
end
