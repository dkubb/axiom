# encoding: utf-8

require 'spec_helper'

describe Function::Numeric::Division, '#type' do
  subject { object.type }

  let(:object) { described_class.new(1, 1) }

  it { should be(Types::Float) }
end
