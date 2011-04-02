require 'spec_helper'

describe Optimizer::Algebra::Rename::ReverseOperand, '#optimize' do
  subject { object.optimize }

  let(:klass)    { Optimizer::Algebra::Rename::ReverseOperand         }
  let(:base)     { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each) }
  let(:limit)    { base.order.take(2)                                 }
  let(:operand)  { limit.rename({}).reverse                           }
  let(:relation) { operand.rename(:id => :other_id)                   }
  let(:object)   { klass.new(relation)                                }

  before do
    object.operation.should be_kind_of(Algebra::Rename)
    object.operand.should be_kind_of(Relation::Operation::Reverse)
  end

  it { should be_kind_of(Relation::Operation::Reverse) }

  its(:operand) { should eql(limit.rename(:id => :other_id)) }

  its(:directions) { should == [ relation[:other_id].desc ] }
end
