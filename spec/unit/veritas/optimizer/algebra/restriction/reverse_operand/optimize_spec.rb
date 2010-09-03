require 'spec_helper'

describe 'Veritas::Optimizer::Algebra::Restriction::ReverseOperand#optimize' do
  subject { object.optimize }

  let(:klass)     { Optimizer::Algebra::Restriction::ReverseOperand          }
  let(:order)     { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each).order }
  let(:predicate) { order[:id].eq(1)                                         }
  let(:object)    { klass.new(relation)                                      }

  before do
    object.operation.should be_kind_of(Algebra::Restriction)
    object.operand.should be_kind_of(Relation::Operation::Reverse)
  end

  context 'when new operation is optimizable' do
    let(:relation) { order.limit(2).restrict(predicate).reverse.restrict(predicate) }

    it { should be_kind_of(Relation::Operation::Reverse) }

    its(:operand) { should eql(order.limit(2).restrict(predicate)) }
  end

  context 'when new operation is not optimizable' do
    let(:relation) { order.limit(2).reverse.restrict(predicate) }

    it { should be_kind_of(Relation::Operation::Reverse) }

    its(:operand) { should eql(order.limit(2).restrict(predicate)) }
  end
end
