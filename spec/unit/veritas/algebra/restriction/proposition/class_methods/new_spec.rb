require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::Proposition.new' do
  describe 'with no arguments' do
    subject { Algebra::Restriction::Proposition.new }

    it { should be_kind_of(Algebra::Restriction::Proposition) }
  end

  describe 'with true argument' do
    subject { Algebra::Restriction::Proposition.new(true) }

    it { should equal(Algebra::Restriction::True.instance) }
  end

  describe 'with false argument' do
    subject { Algebra::Restriction::Proposition.new(false) }

    it { should equal(Algebra::Restriction::False.instance) }
  end
end
