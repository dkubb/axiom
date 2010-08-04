require 'spec_helper'

describe 'Veritas::Algebra::Restriction#optimized?' do
  subject { restriction.optimized? }

  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }

  context 'with an optimized operand' do
    let(:restriction) { Algebra::Restriction.new(relation, predicate) }

    before do
      restriction.operand.should be_optimized
    end

    context 'and an optimized predicate' do
      let(:predicate) { relation[:id].eq(1) }

      it { should be(true) }
    end

    context 'and an unoptimized predicate' do
      let(:predicate) { relation[:id].eq(1).and(Logic::Proposition::True.instance) }

      it { should be(false) }
    end
  end

  context 'with an unoptimized operand' do
    let(:projection)  { relation.project(relation.header)               }
    let(:restriction) { Algebra::Restriction.new(projection, predicate) }

    before do
      restriction.operand.should be_optimized
    end

    context 'and an optimized predicate' do
      let(:predicate) { relation[:id].eq(1) }

      it { should be(false) }
    end

    context 'and an unoptimized predicate' do
      let(:predicate) { relation[:id].eq(1).and(Logic::Proposition::True.instance) }

      it { should be(false) }
    end
  end
end
