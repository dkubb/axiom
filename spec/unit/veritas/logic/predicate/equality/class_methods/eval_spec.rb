require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Predicate::Equality.eval' do
  context 'with statement that is true' do
    subject { Logic::Predicate::Equality.eval(true, true) }

    it { should be(true) }
  end

  context 'with statement that is false' do
    subject { Logic::Predicate::Equality.eval(true, false) }

    it { should be(false) }
  end
end
