require 'spec_helper'

describe 'Veritas::Optimizer::Algebra::Projection::SetOperand#optimize' do
  subject { object.optimize }

  let(:klass)      { Optimizer::Algebra::Projection::SetOperand                                       }
  let(:header)     { Relation::Header.new([ [ :id, Integer ], [ :name, String ], [ :age, Integer ] ]) }
  let(:base_left)  { Relation.new(header, [ [ 1, 'Dan Kubb', 35 ] ].each)                             }
  let(:base_right) { Relation.new(header, [ [ 2, 'Dan Kubb', 35 ] ].each)                             }
  let(:relation)   { left.union(right).project([ :id ])                                               }
  let(:object)     { klass.new(relation)                                                              }

  before do
    object.operation.should be_kind_of(Algebra::Projection)
    object.operand.should be_kind_of(Relation::Operation::Set)
  end

  context 'with a projection under the set operation' do
    let(:left)  { base_left.project([ :id, :name ])  }
    let(:right) { base_right.project([ :id, :name ]) }

    it { should be_kind_of(Relation::Operation::Set) }

    its(:left) { should eql(base_left.project([ :id ])) }

    its(:right) { should eql(base_right.project([ :id ])) }
  end

  context 'without a projection under the set operation' do
    let(:left)  { base_left  }
    let(:right) { base_right }

    it { should be_kind_of(Relation::Operation::Set) }

    its(:left) { should eql(base_left.project([ :id ])) }

    its(:right) { should eql(base_right.project([ :id ])) }
  end
end
