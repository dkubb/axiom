require 'spec_helper'

describe Optimizer::Algebra::Projection::SetOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:header)   { Relation::Header.new([ [ :id, Integer ], [ :name, String ] ]) }
  let(:left)     { Relation.new(header, [ [ 1, 'Dan Kubb', 35 ] ].each)          }
  let(:right)    { Relation.new(header, [ [ 2, 'Dan Kubb', 35 ] ].each)          }
  let(:relation) { operand.project([ :id ])                                      }
  let(:object)   { described_class.new(relation)                                 }

  before do
    object.operation.should be_kind_of(Algebra::Projection)
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
