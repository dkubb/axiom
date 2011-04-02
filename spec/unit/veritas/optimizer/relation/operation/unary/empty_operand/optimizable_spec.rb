require 'spec_helper'

describe Optimizer::Relation::Operation::Unary::EmptyOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:relation) { mock('Relation', :operand => operand) }
  let(:object)   { described_class.new(relation)         }

  context 'when the operand is empty' do
    let(:operand) { Relation::Empty.new([ [ :id, Integer ] ]) }

    it { should be(true) }
  end

  context 'when the operand is not empty' do
    let(:operand) { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }

    it { should be(false) }
  end
end
