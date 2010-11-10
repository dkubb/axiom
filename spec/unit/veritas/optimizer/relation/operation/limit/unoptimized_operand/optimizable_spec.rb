require 'spec_helper'

describe 'Veritas::Optimizer::Relation::Operation::Limit::UnoptimizedOperand#optimizable?' do
  subject { object.optimizable? }

  let(:klass)    { Optimizer::Relation::Operation::Limit::UnoptimizedOperand }
  let(:header)   { Relation::Header.new([ [ :id, Integer ] ])                }
  let(:base)     { Relation.new(header, [ [ 1 ] ].each).order                }
  let(:relation) { operand.take(1)                                           }
  let(:object)   { klass.new(relation)                                       }

  before do
    object.operation.should be_kind_of(Relation::Operation::Limit)
  end

  context 'when the operand is optimizable' do
    let(:operand) { base.project(header) }

    it { should be(true) }
  end

  context 'when the operand is not optimizable' do
    let(:operand) { base }

    it { should be(false) }
  end
end
