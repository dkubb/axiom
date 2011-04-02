require 'spec_helper'

describe Optimizer::Algebra::Restriction::FalsePredicate, '#optimizable?' do
  subject { object.optimizable? }

  let(:header)   { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:base)     { Relation.new(header, [ [ 1 ] ].each)       }
  let(:relation) { base.restrict(predicate)                   }
  let(:object)   { described_class.new(relation)              }

  before do
    object.operation.should be_kind_of(Algebra::Restriction)
  end

  context 'when the predicate is false' do
    let(:predicate) { Logic::Proposition::False.instance }

    it { should be(true) }
  end

  context 'when the predicate is not false' do
    let(:predicate) { Logic::Proposition::True.instance }

    it { should be(false) }
  end
end
