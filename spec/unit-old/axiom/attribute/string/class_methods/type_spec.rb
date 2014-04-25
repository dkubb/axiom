# encoding: utf-8

require 'spec_helper'

describe Attribute::String, '.type' do
  subject { object.type }

  let(:object) { described_class }

  it_should_behave_like 'an idempotent method'

  it { should be(Types::String) }
end
