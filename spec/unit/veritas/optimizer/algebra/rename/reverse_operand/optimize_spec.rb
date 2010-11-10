require 'spec_helper'

describe 'Veritas::Optimizer::Algebra::Rename::ReverseOperand#optimize' do
  subject { object.optimize }

  let(:klass)  { Optimizer::Algebra::Rename::ReverseOperand         }
  let(:base)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each) }
  let(:object) { klass.new(relation)                                }

  before do
    object.operation.should be_kind_of(Algebra::Rename)
    object.operand.should be_kind_of(Relation::Operation::Reverse)
  end

  context 'when the operand is a reverse containing a rename operation' do
    let(:limit)    { base.order.take(2)                     }
    let(:operand)  { limit.rename(:id => :other_id).reverse }
    let(:relation) { operand.rename(:other_id => :id)       }

    it { should be_kind_of(Relation::Operation::Reverse) }

    its(:operand) { should eql(limit) }

    its(:directions) { should == [ base[:id].desc ] }
  end

  context 'when the operand is a reverse not containing a rename operation' do
    let(:operand)  { base.order.take(2).reverse       }
    let(:relation) { operand.rename(:id => :other_id) }

    it { should be_kind_of(Relation::Operation::Reverse) }

    its(:operand) { should eql(base.rename(:id => :other_id).order.take(2)) }

    its(:directions) { should == [ relation[:other_id].desc ] }
  end
end
