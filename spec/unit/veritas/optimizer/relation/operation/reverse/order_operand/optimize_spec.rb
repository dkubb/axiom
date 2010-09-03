require 'spec_helper'

describe 'Veritas::Optimizer::Relation::Operation::Reverse::OrderOperand#optimize' do
  subject { object.optimize }

  let(:klass)    { Optimizer::Relation::Operation::Reverse::OrderOperand }
  let(:base)     { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each)    }
  let(:operand)  { base.order                                            }
  let(:relation) { operand.reverse                                       }
  let(:object)   { klass.new(relation)                                   }

  before do
    object.operation.should be_kind_of(Relation::Operation::Reverse)
  end

  it { should eql(base.order(relation.directions)) }
end
