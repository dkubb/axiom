require 'spec_helper'

describe Optimizer::Relation::Operation::Reverse::ReverseOperand, '#optimize' do
  subject { object.optimize }

  let(:base)     { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each) }
  let(:operand)  { base.order.reverse                                 }
  let(:relation) { operand.reverse                                    }
  let(:object)   { described_class.new(relation)                      }

  before do
    object.operation.should be_kind_of(Relation::Operation::Reverse)
  end

  it { should equal(base) }
end
