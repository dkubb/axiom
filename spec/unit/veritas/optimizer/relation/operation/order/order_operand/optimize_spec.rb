require 'spec_helper'

describe Optimizer::Relation::Operation::Order::OrderOperand, '#optimize' do
  subject { object.optimize }

  let(:base)     { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each) }
  let(:order)    { base.order                                         }
  let(:relation) { order.order(order.directions.reverse)              }
  let(:object)   { described_class.new(relation)                      }

  before do
    object.should be_optimizable
  end

  it { should be_kind_of(Relation::Operation::Order) }

  its(:operand) { should equal(base) }

  its(:directions) { should eql(order.directions.reverse) }
end
