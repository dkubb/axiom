require 'spec_helper'

describe Optimizer, '#operation' do
  subject { object.operation }

  let(:described_class) { Class.new(Optimizer)           }
  let(:operation)       { mock('Operation')              }
  let(:object)          { described_class.new(operation) }

  it { should equal(operation) }
end
