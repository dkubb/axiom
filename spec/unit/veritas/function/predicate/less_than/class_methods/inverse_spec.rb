# encoding: utf-8

require 'spec_helper'

describe Function::Predicate::LessThan, '.inverse' do
  subject { object.inverse }

  let(:object) { described_class }

  it { should equal(Function::Predicate::GreaterThanOrEqualTo) }
end
