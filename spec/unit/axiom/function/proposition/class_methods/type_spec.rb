# encoding: utf-8

require 'spec_helper'

describe Function::Proposition, '.type' do
  subject { object.type }

  let(:object) { Class.new(Function::Proposition) }

  it { should be(Types::Boolean) }
end
