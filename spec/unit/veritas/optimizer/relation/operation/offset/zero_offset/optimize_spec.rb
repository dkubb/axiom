require 'spec_helper'

describe 'Veritas::Optimizer::Relation::Operation::Offset::ZeroOffset#optimize' do
  subject { object.optimize }

  let(:klass)    { Optimizer::Relation::Operation::Offset::ZeroOffset       }
  let(:order)    { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each).order }
  let(:relation) { order.offset(0)                                          }
  let(:object)   { klass.new(relation)                                      }

  before do
    object.operation.should be_kind_of(Relation::Operation::Offset)
  end

  it { should equal(order) }
end
