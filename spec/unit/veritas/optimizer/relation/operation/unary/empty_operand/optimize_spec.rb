require 'spec_helper'

describe 'Veritas::Optimizer::Relation::Operation::Unary::EmptyOperand#optimize' do
  subject { object.optimize }

  let(:klass)    { Optimizer::Relation::Operation::Unary::EmptyOperand }
  let(:operand)  { mock('Empty Operand')                               }
  let(:relation) { mock('Relation', :operand => operand)               }
  let(:object)   { klass.new(relation)                                 }

  before do
    operand.stub!(:optimize).and_return(operand)
  end

  it { should equal(operand) }
end
