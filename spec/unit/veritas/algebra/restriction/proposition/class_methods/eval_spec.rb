require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::Proposition.eval' do
  subject { Algebra::Restriction::Proposition.eval }

  it { method(:subject).should raise_error(NotImplementedError, 'Veritas::Algebra::Restriction::Proposition.eval must be implemented') }

end
