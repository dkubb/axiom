require 'spec_helper'

describe Optimizer::Logic::Connective::Negation, '#operand' do
  subject { object.operand }

  let(:optimized_operand) { mock('Optimized Operand')                       }
  let(:operand)           { mock('Operand', :optimize => optimized_operand) }
  let(:negation)          { mock('Negation', :operand => operand)           }
  let(:object)            { described_class.new(negation)                   }

  it { should equal(optimized_operand) }
end
