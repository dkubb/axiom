require 'spec_helper'

describe Optimizer::Algebra::Rename::OrderOperand, '#optimize' do
  subject { object.optimize }

  let(:base)     { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each) }
  let(:operand)  { base.order                                         }
  let(:relation) { operand.rename(:id => :other_id)                   }
  let(:object)   { described_class.new(relation)                      }

  before do
    object.should be_optimizable
  end

  it { should be_kind_of(Relation::Operation::Order) }

  its(:operand) { should eql(base.rename(:id => :other_id)) }

  its(:directions) { should == [ relation[:other_id].asc ] }
end
