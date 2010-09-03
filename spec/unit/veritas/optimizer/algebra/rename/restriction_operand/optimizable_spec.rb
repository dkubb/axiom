require 'spec_helper'

describe 'Veritas::Optimizer::Algebra::Rename::RestrictionOperand#optimizable?' do
  subject { object.optimizable? }

  let(:klass)     { Optimizer::Algebra::Rename::RestrictionOperand }
  let(:header)    { Relation::Header.new([ [ :id, Integer ] ])     }
  let(:base)      { Relation.new(header, [ [ 1 ] ].each)           }
  let(:predicate) { base[:id].eq(1)                                }
  let(:relation)  { operand.rename(:id => :other_id)               }
  let(:object)    { klass.new(relation)                            }

  before do
    object.operation.should be_kind_of(Algebra::Rename)
  end

  context 'when the operand is a restriction' do
    let(:operand) { base.restrict(predicate) }

    it { should be(true) }
  end

  context 'when the operand is not a restriction' do
    let(:operand) { base }

    it { should be(false) }
  end
end
