require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::False.eval' do
  subject { Algebra::Restriction::False.eval }

  it { should be_false }
end
