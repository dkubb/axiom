# encoding: utf-8

require 'spec_helper'

describe Function::Proposition::Contradiction, '.inverse' do
  subject { object.inverse }

  let(:object) { described_class }

  it { should equal(Function::Proposition::Tautology) }
end
