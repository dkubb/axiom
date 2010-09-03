require 'spec_helper'

describe 'Veritas::Optimizer#operation' do
  subject { object.operation }

  let(:klass)     { Class.new(Optimizer) }
  let(:operation) { mock('Operation')    }
  let(:object)    { klass.new(operation) }

  it { should equal(operation) }
end
