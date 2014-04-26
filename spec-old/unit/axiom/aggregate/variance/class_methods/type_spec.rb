# encoding: utf-8

require 'spec_helper'

describe Aggregate::Variance, '.type' do
  subject { object.type }

  let(:object) { described_class }

  it { should be(Types::Float) }
end
