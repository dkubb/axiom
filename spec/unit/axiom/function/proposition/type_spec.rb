# encoding: utf-8

require 'spec_helper'

describe Function::Proposition, '#type' do
  subject { object.type }

  let(:described_class) { Class.new(Function::Proposition) }
  let(:object)          { described_class.new              }

  it { should equal(Attribute::Boolean) }
end
