require 'spec_helper'

describe Optimizer::Algebra::Restriction::OrderOperand, '#optimize' do
  subject { object.optimize }

  let(:base)      { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each) }
  let(:predicate) { base[:id].eq(1)                                    }
  let(:relation)  { base.order.restrict(predicate)                     }
  let(:object)    { described_class.new(relation)                      }

  before do
    object.should be_optimizable
  end

  it { should be_kind_of(Relation::Operation::Order) }

  its(:operand) { should eql(base.restrict(predicate)) }
end
