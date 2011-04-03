require 'spec_helper'

describe Optimizer::Algebra::Restriction::RestrictionOperand, '#optimize' do
  subject { object.optimize }

  let(:header)          { Relation::Header.new([ [ :id, Integer ] ])         }
  let(:base)            { Relation.new(header, [ [ 1 ] ].each)               }
  let(:predicate)       { header[:id].eq(1)                                  }
  let(:other_predicate) { header[:id].include([ 1 ])                         }
  let(:relation)        { base.restrict(predicate).restrict(other_predicate) }
  let(:object)          { described_class.new(relation)                      }

  before do
    object.should be_optimizable
  end

  it { should be_kind_of(Algebra::Restriction) }

  its(:operand) { should equal(base) }

  its(:predicate) { should equal(predicate) }
end
