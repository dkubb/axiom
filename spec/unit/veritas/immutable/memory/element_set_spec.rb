require 'spec_helper'

describe 'Veritas::Immutable::Memory#[]=' do
  subject { object[key] = value }

  let(:klass)  { Immutable::Memory               }
  let(:object) { klass.new                       }
  let(:key)    { '@key'                          }
  let(:value)  { mock('Value', :frozen? => true) }

  it { should equal(value) }

  it 'sets the instance variable' do
    object.should_not be_instance_variable_defined(key)
    subject
    object.instance_variable_get(key).should equal(value)
  end
end
