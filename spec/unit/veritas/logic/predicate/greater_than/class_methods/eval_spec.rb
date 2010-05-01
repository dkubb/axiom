require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Predicate::GreaterThan.eval' do
  describe 'with statement that is true' do
    subject { Logic::Predicate::GreaterThan.eval(2, 1) }

    it { should be(true) }
  end

  describe 'with statement that is false' do
    subject { Logic::Predicate::GreaterThan.eval(1, 2) }

    it { should be(false) }
  end
end
