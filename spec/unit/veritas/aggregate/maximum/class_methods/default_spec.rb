# encoding: utf-8

require 'spec_helper'

describe Aggregate::Maximum, '.default' do
  subject { object.default }

  let(:object) { described_class }

  it_should_behave_like 'an idempotent method'

  it { should eql(-Float::INFINITY) }
end
