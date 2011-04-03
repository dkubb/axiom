require 'spec_helper'

describe Optimizer::Relation::Operation::Unary::EmptyOperand, '#optimize' do
  subject { object.optimize }

  let(:operand)  { Relation::Empty.new([ [ :id, Integer ] ]) }
  let(:relation) { operand.rename({})                        }
  let(:object)   { described_class.new(relation)             }

  before do
    object.should be_optimizable
  end

  it { should equal(operand) }
end
