# encoding: utf-8

require 'spec_helper'

describe Attribute::Integer, '.type' do
  subject { object.type }

  let(:object) { described_class }

  it_should_behave_like 'an idempotent method'

  it { should be(Types::Integer) }
end
