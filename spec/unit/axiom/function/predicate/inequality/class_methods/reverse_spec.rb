# encoding: utf-8

require 'spec_helper'

describe Function::Predicate::Inequality, '.reverse' do
  subject { object.reverse }

  let(:object) { described_class }

  it { should be(Function::Predicate::Inequality) }
end
