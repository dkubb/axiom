require 'spec_helper'

describe Optimizer::Relation::Operation::Reverse::ReverseOperand, '#optimize' do
  subject { object.optimize }

  let(:base)     { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each) }
  let(:limit)    { base.order.take(2)                                 }
  let(:operand)  { limit.reverse                                      }
  let(:relation) { operand.reverse                                    }
  let(:object)   { described_class.new(relation)                      }

  before do
    object.should be_optimizable
  end

  it { should equal(limit) }
end
