require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Predicate::LessThanOrEqualTo.eval' do
  describe 'with statement that is true' do
    subject { Logic::Predicate::LessThanOrEqualTo.eval(1, 1) }

    it { should be_true }
  end

  describe 'with statement that is false' do
    subject { Logic::Predicate::LessThanOrEqualTo.eval(1, 0) }

    it { should be_false }
  end
end
