# encoding: utf-8

require 'spec_helper'

describe Function::Predicate, '.type' do
  subject { object.type }

  let(:object) { Class.new(Function::Predicate) }

  it { should be(Types::Boolean) }
end
