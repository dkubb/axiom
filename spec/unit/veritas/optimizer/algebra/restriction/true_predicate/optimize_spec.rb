require 'spec_helper'

describe 'Veritas::Optimizer::Algebra::Restriction::TruePredicate#optimize' do
  subject { object.optimize }

  let(:klass)     { Optimizer::Algebra::Restriction::TruePredicate }
  let(:header)    { Relation::Header.new([ [ :id, Integer ] ])     }
  let(:base)      { Relation.new(header, [ [ 1 ] ].each)           }
  let(:predicate) { Logic::Proposition::True.instance              }
  let(:relation)  { base.restrict(predicate)                       }
  let(:object)    { klass.new(relation)                            }

  before do
    object.operation.should be_kind_of(Algebra::Restriction)
  end

  it { should equal(base) }
end
