require 'spec_helper'

describe 'Veritas::Optimizer::Algebra::Rename::SetOperand#optimizable?' do
  subject { object.optimizable? }

  let(:klass)    { Optimizer::Algebra::Rename::SetOperand     }
  let(:header)   { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:left)     { Relation.new(header, [ [ 1 ] ].each)       }
  let(:right)    { Relation.new(header, [ [ 2 ] ].each)       }
  let(:relation) { operand.rename(:id => :other_id)           }
  let(:object)   { klass.new(relation)                        }

  before do
    object.operation.should be_kind_of(Algebra::Rename)
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
