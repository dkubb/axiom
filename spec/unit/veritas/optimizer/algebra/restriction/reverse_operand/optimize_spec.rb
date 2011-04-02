require 'spec_helper'

describe Optimizer::Algebra::Restriction::ReverseOperand, '#optimize' do
  subject { object.optimize }

  let(:order)     { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each).order }
  let(:predicate) { order[:id].eq(1)                                         }
  let(:relation)  { order.take(2).reverse.restrict(predicate)                }
  let(:object)    { described_class.new(relation)                            }

  before do
    object.operation.should be_kind_of(Algebra::Restriction)
    object.operand.should be_kind_of(Relation::Operation::Reverse)
  end

  it { should be_kind_of(Relation::Operation::Reverse) }

  its(:operand) { should eql(order.take(2).restrict(predicate)) }
end
