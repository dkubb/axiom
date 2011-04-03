require 'spec_helper'

describe Optimizer::Algebra::Rename::ReverseOperand, '#optimize' do
  subject { object.optimize }

  let(:base)     { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each) }
  let(:limit)    { base.order.take(2)                                 }
  let(:operand)  { limit.rename({}).reverse                           }
  let(:relation) { operand.rename(:id => :other_id)                   }
  let(:object)   { described_class.new(relation)                      }

  before do
    object.should be_optimizable
  end

  it { should be_kind_of(Relation::Operation::Reverse) }

  its(:operand) { should eql(limit.rename(:id => :other_id)) }

  its(:directions) { should == [ relation[:other_id].desc ] }
end
