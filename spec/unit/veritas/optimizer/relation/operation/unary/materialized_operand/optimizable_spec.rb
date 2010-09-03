require 'spec_helper'

describe 'Veritas::Optimizer::Relation::Operation::Unary::MaterializedOperand#optimizable?' do
  subject { object.optimizable? }

  let(:klass)    { Optimizer::Relation::Operation::Unary::MaterializedOperand }
  let(:relation) { mock('Relation', :operand => operand)                      }
  let(:object)   { klass.new(relation)                                        }

  context 'when the operand is materialized' do
    let(:operand) { Relation::Materialized.new([ [ :id, Integer ] ], [ [ 1 ] ]) }

    it { should be(true) }
  end

  context 'when the operand is not materialized' do
    let(:operand) { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each) }

    it { should be(false) }
  end
end
