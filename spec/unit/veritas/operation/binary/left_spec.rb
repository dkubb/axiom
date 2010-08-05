require 'spec_helper'

describe 'Veritas::Operation::Binary#left' do
  subject { binary_operation.left }

  let(:klass)            { Class.new { include Operation::Binary } }
  let(:left)             { mock('Left')                            }
  let(:right)            { mock('Right')                           }
  let(:binary_operation) { klass.new(left, right)                  }

  it { should equal(left) }
end
