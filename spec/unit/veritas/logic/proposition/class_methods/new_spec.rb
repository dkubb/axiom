require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Proposition.new' do
  context 'with no arguments' do
    subject { Logic::Proposition.new }

    it { should be_kind_of(Logic::Proposition) }
  end

  context 'with true argument' do
    subject { Logic::Proposition.new(true) }

    it { should equal(Logic::Proposition::True.instance) }
  end

  context 'with false argument' do
    subject { Logic::Proposition.new(false) }

    it { should equal(Logic::Proposition::False.instance) }
  end
end
