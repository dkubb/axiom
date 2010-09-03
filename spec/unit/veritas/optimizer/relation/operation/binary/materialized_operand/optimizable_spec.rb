require 'spec_helper'

describe 'Veritas::Optimizer::Relation::Operation::Binary::MaterializedOperand#optimizable?' do
  subject { object.optimizable? }

  let(:klass)            { Optimizer::Relation::Operation::Binary::MaterializedOperand }
  let(:materialized)     { Relation::Materialized.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:not_materialized) { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each)          }
  let(:left)             { not_materialized                                            }
  let(:right)            { not_materialized                                            }
  let(:relation)         { left.union(right)                                           }
  let(:object)           { klass.new(relation)                                         }

  context 'when the right and right are materialized' do
    let(:left)  { materialized }
    let(:right) { materialized }

    it { should be(true) }
  end

  context 'when the left is materialized' do
    let(:left) { materialized }

    it { should be(false) }
  end

  context 'when the right is materialized' do
    let(:right) { materialized }

    it { should be(false) }
  end

  context 'when the left and right are not materialized' do
    it { should be(false) }
  end
end
