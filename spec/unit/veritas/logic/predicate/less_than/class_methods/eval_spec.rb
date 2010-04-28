require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Predicate::LessThan.eval' do
  describe 'with statement that is true' do
    subject { Logic::Predicate::LessThan.eval(1, 2) }

    it { should be_true }
  end

  describe 'with statement that is false' do
    subject { Logic::Predicate::LessThan.eval(1, 1) }

    it { should be_false }
  end
end
