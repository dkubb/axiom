# encoding: utf-8

require 'spec_helper'

describe Function::Predicate::GreaterThanOrEqualTo, '.operation' do
  subject { object.operation }

  let(:object) { described_class }

  it { should be(:>=) }
end
