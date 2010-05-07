require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Predicate::Match.eval' do
  context 'with statement that is true' do
    subject { Logic::Predicate::Match.eval('Dan Kubb', /Dan Kubb/) }

    it { should be(true) }
  end

  context 'with statement that is false' do
    subject { Logic::Predicate::Match.eval('Alex Kubb', /Dan Kubb/) }

    it { should be(false) }
  end
end
