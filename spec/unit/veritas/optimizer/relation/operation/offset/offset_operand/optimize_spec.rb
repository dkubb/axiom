require 'spec_helper'

describe Optimizer::Relation::Operation::Offset::OffsetOperand, '#optimize' do
  subject { object.optimize }

  let(:order)    { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each).order }
  let(:relation) { order.drop(1).drop(2)                                    }
  let(:object)   { described_class.new(relation)                            }

  before do
    object.operation.should be_kind_of(Relation::Operation::Offset)
  end

  it { should be_kind_of(Relation::Operation::Offset) }

  its(:operand) { should equal(order) }

  its(:offset) { should == 3 }
end
