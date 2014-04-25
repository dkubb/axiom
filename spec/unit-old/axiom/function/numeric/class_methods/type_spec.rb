# encoding: utf-8

require 'spec_helper'

describe Function::Numeric, '.type' do
  subject { object.type }

  let(:object) { described_class }

  it { should be(Types::Numeric) }
end
