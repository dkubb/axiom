# encoding: utf-8

require 'spec_helper'

describe Immutable::Memory, '#[]=' do
  subject { object[key] = value }

  let(:object) { described_class.new }
  let(:key)    { '@key'              }
  let(:value)  { mock('Value')       }

  it { should equal(value) }

  it 'sets the instance variable' do
    object.should_not be_instance_variable_defined(key)
    subject
    object.instance_variable_get(key).should equal(value)
  end
end
