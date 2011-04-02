require 'spec_helper'

describe Optimizer::Algebra::Restriction::RestrictionOperand, '#optimize' do
  subject { object.optimize }

  let(:klass)           { Optimizer::Algebra::Restriction::RestrictionOperand }
  let(:header)          { Relation::Header.new([ [ :id, Integer ] ])          }
  let(:base)            { Relation.new(header, [ [ 1 ] ].each)                }
  let(:predicate)       { header[:id].eq(1)                                   }
  let(:other_predicate) { header[:id].include([ 1 ])                          }
  let(:relation)        { base.restrict(predicate).restrict(other_predicate)  }
  let(:object)          { klass.new(relation)                                 }

  before do
    object.operation.should be_kind_of(Algebra::Restriction)
    object.operand.should be_kind_of(Algebra::Restriction)
  end

  it { should be_kind_of(Algebra::Restriction) }

  its(:operand) { should equal(base) }

  its(:predicate) { should equal(predicate) }
end
