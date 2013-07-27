# encoding: utf-8

require 'spec_helper'

describe Function::String::Length, '#type' do
  subject { object.type }

  let(:object) { described_class.new('string') }

  it { should be(Attribute::Integer) }
end
