# encoding: utf-8

require 'spec_helper'

describe Function::Proposition::Contradiction, '#inverse' do
  subject { object.inverse }

  let(:object) { described_class.instance }

  it_should_behave_like 'an invertible method'

  it { should be(Function::Proposition::Tautology.instance) }
end
