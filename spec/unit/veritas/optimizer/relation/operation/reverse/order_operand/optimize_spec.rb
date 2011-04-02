require 'spec_helper'

describe Optimizer::Relation::Operation::Reverse::OrderOperand, '#optimize' do
  subject { object.optimize }

  let(:base)     { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each) }
  let(:operand)  { base.order                                         }
  let(:relation) { operand.reverse                                    }
  let(:object)   { described_class.new(relation)                      }

  before do
    object.operation.should be_kind_of(Relation::Operation::Reverse)
  end

  it { should be_kind_of(Relation::Operation::Order) }

  its(:operand) { should equal(base) }

  its(:directions) { should equal(relation.directions) }
end
