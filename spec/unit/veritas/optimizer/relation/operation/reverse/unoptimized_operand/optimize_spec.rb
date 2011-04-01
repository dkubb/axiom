require 'spec_helper'

describe 'Veritas::Optimizer::Relation::Operation::Reverse::UnoptimizedOperand#optimize' do
  subject { object.optimize }

  let(:klass)    { Optimizer::Relation::Operation::Reverse::UnoptimizedOperand }
  let(:base)     { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each)          }
  let(:order)    { base.order                                                  }
  let(:relation) { order.rename({}).reverse                                    }
  let(:object)   { klass.new(relation)                                         }

  before do
    object.operation.should be_kind_of(Relation::Operation::Reverse)
  end

  it { should be_kind_of(Relation::Operation::Order) }

  it { should_not equal(relation) }

  its(:operand) { should equal(order) }

  its(:directions) { should eql(relation.directions) }
end
