require 'spec_helper'

describe Optimizer::Relation::Operation::Unary::EmptyOperand, '#optimize' do
  subject { object.optimize }

  let(:operand)  { mock('Empty Operand')                 }
  let(:relation) { mock('Relation', :operand => operand) }
  let(:object)   { described_class.new(relation)         }

  before do
    operand.stub!(:optimize).and_return(operand)
  end

  it { should equal(operand) }
end
