require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Connective::Disjunction.eval' do
  describe 'with statement that is true' do
    subject { Logic::Connective::Disjunction.eval(true, false) }

    it { should be(true) }
  end

  describe 'with statement that is false' do
    subject { Logic::Connective::Disjunction.eval(false, false) }

    it { should be(false) }
  end
end
