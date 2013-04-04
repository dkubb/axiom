# encoding: utf-8

require 'spec_helper'

describe Function::Predicate::GreaterThan, '.reverse' do
  subject { object.reverse }

  let(:object) { described_class }

  it { should equal(Function::Predicate::LessThan) }
end
