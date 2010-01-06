require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::Disjunction.eval' do
  describe 'with statement that is true' do
    subject { Algebra::Restriction::Disjunction.eval(true, false) }

    it { should be_true }
  end

  describe 'with statement that is false' do
    subject { Algebra::Restriction::Disjunction.eval(false, false) }

    it { should be_false }
  end
end
