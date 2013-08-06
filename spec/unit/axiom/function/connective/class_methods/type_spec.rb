# encoding: utf-8

require 'spec_helper'

describe Function::Connective, '.type' do
  subject { object.type }

  let(:object) { Class.new(Function::Connective) }

  it { should be(Types::Boolean) }
end
