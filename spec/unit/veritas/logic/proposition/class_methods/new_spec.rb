require 'spec_helper'

describe 'Veritas::Logic::Proposition.new' do
  subject { Logic::Proposition.new(*args) }

  context 'with no arguments' do
    let(:args) { [] }

    it { should be_kind_of(Logic::Proposition) }
  end

  context 'with true argument' do
    let(:args) { [ true ] }

    it { should equal(Logic::Proposition::True.instance) }
  end

  context 'with false argument' do
    let(:args) { [ false ] }

    it { should equal(Logic::Proposition::False.instance) }
  end
end
