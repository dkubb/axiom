require 'spec_helper'

describe 'Veritas::Operation::Binary#right' do
  subject { binary_operation.right }

  let(:klass)            { Class.new { include Operation::Binary } }
  let(:left)             { mock('Left')                            }
  let(:right)            { mock('Right')                           }
  let(:binary_operation) { klass.new(left, right)                  }

  it { should equal(right) }
end
