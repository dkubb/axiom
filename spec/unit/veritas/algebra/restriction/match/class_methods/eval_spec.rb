require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::Match.eval' do
  describe 'with statement that is true' do
    subject { Algebra::Restriction::Match.eval('Dan Kubb', /Dan Kubb/) }

    it { should be_true }
  end

  describe 'with statement that is false' do
    subject { Algebra::Restriction::Match.eval('Alex Kubb', /Dan Kubb/) }

    it { should be_false }
  end
end
