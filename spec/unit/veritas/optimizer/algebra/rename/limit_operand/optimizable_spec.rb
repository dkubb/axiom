require 'spec_helper'

describe Optimizer::Algebra::Rename::LimitOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:klass)    { Optimizer::Algebra::Rename::LimitOperand           }
  let(:base)     { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each) }
  let(:aliases)  { { :id => :other_id }                               }
  let(:relation) { operand.rename(aliases)                            }
  let(:object)   { klass.new(relation)                                }

  before do
    object.operation.should be_kind_of(Algebra::Rename)
  end

  context 'when the operand is an limit operation' do
    let(:operand) { base.order.take(1) }

    it { should be(true) }
  end

  context 'when the operand is not an limit operation' do
    let(:operand) { base }

    it { should be(false) }
  end
end
