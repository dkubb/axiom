require 'spec_helper'

describe 'Veritas::Optimizer::Algebra::Rename::OffsetOperand#optimizable?' do
  subject { object.optimizable? }

  let(:klass)    { Optimizer::Algebra::Rename::OffsetOperand          }
  let(:base)     { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each) }
  let(:aliases)  { { :id => :other_id }                               }
  let(:relation) { operand.rename(aliases)                            }
  let(:object)   { klass.new(relation)                                }

  before do
    object.operation.should be_kind_of(Algebra::Rename)
  end

  context 'when the operand is an offset operation' do
    let(:operand) { base.order.offset(1) }

    it { should be(true) }
  end

  context 'when the operand is not an offset operation' do
    let(:operand) { base }

    it { should be(false) }
  end
end
