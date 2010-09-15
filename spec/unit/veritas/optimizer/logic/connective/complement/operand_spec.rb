require 'spec_helper'

describe 'Veritas::Optimizer::Logic::Connective::Complement#operand' do
  subject { object.operand }

  let(:klass)             { Optimizer::Logic::Connective::Complement        }
  let(:optimized_operand) { mock('Optimized Operand')                       }
  let(:operand)           { mock('Operand', :optimize => optimized_operand) }
  let(:complement)        { mock('Complement', :operand => operand)         }
  let(:object)            { klass.new(complement)                           }

  it { should equal(optimized_operand) }
end
