require 'spec_helper'

describe Optimizer::Relation::Operation::Limit::EqualLimitOperand, '#optimize' do
  subject { object.optimize }

  let(:order)    { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each).order }
  let(:limit)    { order.take(1)                                            }
  let(:relation) { limit.take(1)                                            }
  let(:object)   { described_class.new(relation)                            }

  before do
    object.should be_optimizable
  end

  it { should equal(limit) }
end
