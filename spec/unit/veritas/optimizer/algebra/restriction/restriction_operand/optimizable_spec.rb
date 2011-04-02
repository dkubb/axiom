require 'spec_helper'

describe Optimizer::Algebra::Restriction::RestrictionOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:header)    { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:base)      { Relation.new(header, [ [ 1 ] ].each)       }
  let(:predicate) { header[:id].eq(1)                          }
  let(:relation)  { operand.restrict(predicate)                }
  let(:object)    { described_class.new(relation)              }

  before do
    object.operation.should be_kind_of(Algebra::Restriction)
  end

  context 'when the operand is an restriction operation' do
    let(:other_predicate) { header[:id].include([ 1 ])     }
    let(:operand)         { base.restrict(other_predicate) }

    it { should be(true) }
  end

  context 'when the operand is not a restriction operation' do
    let(:operand) { base }

    it { should be(false) }
  end
end
