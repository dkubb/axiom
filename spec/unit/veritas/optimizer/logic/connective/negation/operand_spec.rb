require 'spec_helper'

describe 'Veritas::Optimizer::Logic::Connective::Negation#operand' do
  subject { object.operand }

  let(:klass)             { Optimizer::Logic::Connective::Negation          }
  let(:optimized_operand) { mock('Optimized Operand')                       }
  let(:operand)           { mock('Operand', :optimize => optimized_operand) }
  let(:negation)          { mock('Negation', :operand => operand)           }
  let(:object)            { klass.new(negation)                             }

  it { should equal(optimized_operand) }
end
