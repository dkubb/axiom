require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::True.eval' do
  subject { Algebra::Restriction::True.eval }

  it { should be_true }
end
