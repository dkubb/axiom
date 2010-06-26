require 'spec_helper'

describe 'Veritas::Operation::Unary#operand' do
  subject { unary_operation.operand }

  let(:klass)           { Class.new { include Operation::Unary } }
  let(:operand)         { mock('Operand')                        }
  let(:unary_operation) { klass.new(operand)                     }

  it { should equal(operand) }
end
