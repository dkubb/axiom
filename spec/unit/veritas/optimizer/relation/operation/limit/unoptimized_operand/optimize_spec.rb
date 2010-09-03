require 'spec_helper'

describe 'Veritas::Optimizer::Relation::Operation::Limit::UnoptimizedOperand#optimize' do
  subject { object.optimize }

  let(:klass)    { Optimizer::Relation::Operation::Limit::UnoptimizedOperand }
  let(:header)   { Relation::Header.new([ [ :id, Integer ] ])                }
  let(:order)    { Relation.new(header, [ [ 1 ] ].each).order                }
  let(:relation) { order.project(header).limit(1)                            }
  let(:object)   { klass.new(relation)                                       }

  before do
    object.operation.should be_kind_of(Relation::Operation::Limit)
  end

  it { should eql(order.limit(1)) }

  its(:operand) { should equal(order) }
end
