# encoding: utf-8

require 'spec_helper'

describe Attribute::Integer, '.primitive' do
  subject { object.primitive }

  let(:object) { described_class }

  it_should_behave_like 'an idempotent method'

  it { should equal(Integer) }
end
