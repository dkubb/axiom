require 'spec_helper'

describe 'Veritas::Immutable::Memory#[]=' do
  subject { memory[key] = value }

  let(:memory) { Immutable::Memory.new }
  let(:key)    { '@key'                }
  let(:value)  { mock('Value')         }

  it { should equal(value) }

  it 'sets the instance variable' do
    memory.should_not be_instance_variable_defined(key)
    subject
    memory.instance_variable_get(key).should equal(value)
  end
end
