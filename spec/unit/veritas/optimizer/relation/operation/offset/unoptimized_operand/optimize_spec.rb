require 'spec_helper'

describe Optimizer::Relation::Operation::Offset::UnoptimizedOperand, '#optimize' do
  subject { object.optimize }

  let(:klass)    { Optimizer::Relation::Operation::Offset::UnoptimizedOperand }
  let(:header)   { Relation::Header.new([ [ :id, Integer ] ])                 }
  let(:order)    { Relation.new(header, [ [ 1 ] ].each).order                 }
  let(:relation) { order.rename({}).drop(1)                                   }
  let(:object)   { klass.new(relation)                                        }

  before do
    object.operation.should be_kind_of(Relation::Operation::Offset)
  end

  it { should be_kind_of(Relation::Operation::Offset) }

  its(:operand) { should equal(order) }

  its(:offset) { should == 1 }
end
