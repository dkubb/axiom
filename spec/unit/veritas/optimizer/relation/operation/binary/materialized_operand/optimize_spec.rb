require 'spec_helper'

describe Optimizer::Relation::Operation::Binary::MaterializedOperand, '#optimize' do
  subject { object.optimize }

  let(:left)     { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:right)    { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:relation) { left.union(right)                             }
  let(:object)   { described_class.new(relation)                 }

  it { should be_kind_of(Relation::Materialized) }

  its(:header) { should equal(relation.header) }

  it { should == [ [ 1 ] ] }
end
