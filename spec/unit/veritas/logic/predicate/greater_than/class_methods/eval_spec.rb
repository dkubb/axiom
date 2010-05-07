require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Predicate::GreaterThan.eval' do
  context 'with statement that is true' do
    subject { Logic::Predicate::GreaterThan.eval(2, 1) }

    it { should be(true) }
  end

  context 'with statement that is false' do
    subject { Logic::Predicate::GreaterThan.eval(1, 2) }

    it { should be(false) }
  end
end
