require 'spec_helper'

describe Optimizer::Algebra::Restriction::SetOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:klass)     { Optimizer::Algebra::Restriction::SetOperand }
  let(:header)    { Relation::Header.new([ [ :id, Integer ] ])  }
  let(:left)      { Relation.new(header, [ [ 1 ] ].each)        }
  let(:right)     { Relation.new(header, [ [ 2 ] ].each)        }
  let(:predicate) { header[:id].eq(1)                           }
  let(:relation)  { operand.restrict(predicate)                 }
  let(:object)    { klass.new(relation)                         }

  before do
    object.operation.should be_kind_of(Algebra::Restriction)
  end

  context 'when the operand is a set operation' do
    let(:operand) { left.union(right) }

    it { should be(true) }
  end

  context 'when the operand is not a set operation' do
    let(:operand) { left }

    it { should be(false) }
  end
end
