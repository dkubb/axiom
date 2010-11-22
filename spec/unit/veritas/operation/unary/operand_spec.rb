require 'spec_helper'

describe 'Veritas::Operation::Unary#operand' do
  subject { object.operand }

  let(:klass)   { Class.new { include Operation::Unary } }
  let(:operand) { mock('Operand')                        }
  let(:object)  { klass.new(operand)                     }

  it { should equal(operand) }
end
