require 'spec_helper'

describe Optimizer::Relation::Operation::Offset::ZeroOffset, '#optimize' do
  subject { object.optimize }

  let(:order)    { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each).order }
  let(:relation) { order.drop(0)                                            }
  let(:object)   { described_class.new(relation)                            }

  before do
    object.operation.should be_kind_of(Relation::Operation::Offset)
  end

  it { should equal(order) }
end
