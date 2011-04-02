require 'spec_helper'

describe Optimizer::Algebra::Rename::OrderOperand, '#optimize' do
  subject { object.optimize }

  let(:klass)    { Optimizer::Algebra::Rename::OrderOperand           }
  let(:base)     { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each) }
  let(:operand)  { base.order                                         }
  let(:relation) { operand.rename(:id => :other_id)                   }
  let(:object)   { klass.new(relation)                                }

  before do
    object.operation.should be_kind_of(Algebra::Rename)
    object.operand.should be_kind_of(Relation::Operation::Order)
  end

  it { should be_kind_of(Relation::Operation::Order) }

  its(:operand) { should eql(base.rename(:id => :other_id)) }

  its(:directions) { should == [ relation[:other_id].asc ] }
end
