# encoding: utf-8

require 'spec_helper'

describe Function::Proposition::Tautology, '.inverse' do
  subject { object.inverse }

  let(:object) { described_class }

  it { should equal(Function::Proposition::Contradiction) }
end
