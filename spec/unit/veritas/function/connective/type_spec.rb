# encoding: utf-8

require 'spec_helper'

describe Function::Connective, '#type' do
  subject { object.type }

  let(:described_class) { Class.new(Function::Connective) }
  let(:object)          { described_class.new             }

  it { should equal(Attribute::Boolean) }
end
