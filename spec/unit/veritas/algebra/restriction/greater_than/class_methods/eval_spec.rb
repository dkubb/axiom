require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::GreaterThan.eval' do
  describe 'with statement that is true' do
    subject { Algebra::Restriction::GreaterThan.eval(2, 1) }

    it { should be_true }
  end

  describe 'with statement that is false' do
    subject { Algebra::Restriction::GreaterThan.eval(1, 2) }

    it { should be_false }
  end
end
