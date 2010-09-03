require 'spec_helper'

describe 'Veritas::Optimizer::Algebra::Restriction::OrderOperand#optimize' do
  subject { object.optimize }

  let(:klass)     { Optimizer::Algebra::Restriction::OrderOperand      }
  let(:base)      { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each) }
  let(:predicate) { base[:id].eq(1)                                    }
  let(:object)    { klass.new(relation)                                }

  before do
    object.operation.should be_kind_of(Algebra::Restriction)
    object.operand.should be_kind_of(Relation::Operation::Order)
  end

  context 'when new operation is optimizable' do
    let(:relation) { base.restrict(predicate).order.restrict(predicate) }

    it { should be_kind_of(Relation::Operation::Order) }

    its(:operand) { should eql(base.restrict(predicate)) }
  end

  context 'when new operation is not optimizable' do
    let(:relation) { base.order.restrict(predicate) }

    it { should be_kind_of(Relation::Operation::Order) }

    its(:operand) { should eql(base.restrict(predicate)) }
  end
end
