# encoding: utf-8

require 'spec_helper'

describe Function::Predicate::GreaterThanOrEqualTo, '.inverse' do
  subject { object.inverse }

  let(:object) { described_class }

  it { should equal(Function::Predicate::LessThan) }
end
