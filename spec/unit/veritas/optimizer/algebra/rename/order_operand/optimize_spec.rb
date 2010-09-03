require 'spec_helper'

describe 'Veritas::Optimizer::Algebra::Rename::OrderOperand#optimize' do
  subject { object.optimize }

  let(:klass)  { Optimizer::Algebra::Rename::OrderOperand           }
  let(:base)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each) }
  let(:object) { klass.new(relation)                                }

  before do
    object.operation.should be_kind_of(Algebra::Rename)
    object.operand.should be_kind_of(Relation::Operation::Order)
  end

  context 'when the operand is an order containing a rename operation' do
    let(:operand)  { base.rename(:id => :other_id).order }
    let(:relation) { operand.rename(:other_id => :id)    }

    it { should be_kind_of(Relation::Operation::Order) }

    its(:operand) { should equal(base) }

    its(:directions) { should == [ base[:id].asc ] }
  end

  context 'when the operand is an order not containing a rename operation' do
    let(:operand)  { base.order                       }
    let(:relation) { operand.rename(:id => :other_id) }

    it { should be_kind_of(Relation::Operation::Order) }

    its(:operand) { should eql(base.rename(:id => :other_id)) }

    its(:directions) { should == [ relation[:other_id].asc ] }
  end
end
