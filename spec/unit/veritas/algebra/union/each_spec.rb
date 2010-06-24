require 'spec_helper'

describe 'Veritas::Algebra::Union#each' do
  subject { union.each { |tuple| yields << tuple } }

  let(:header) { [ [ :id, Integer ] ]            }
  let(:left)   { Relation.new(header, [ [ 1 ] ]) }
  let(:yields) { []                              }

  context 'with relations having similar bodies' do
    let(:union) { Algebra::Union.new(left, left.dup) }

    it { should equal(union) }

    it 'yields the union' do
      expect { subject }.to change { yields.dup }.from([]).to([ [ 1 ] ])
    end
  end

  context 'with relations having different bodies' do
    let(:right) { Relation.new(header, [ [ 2 ] ]) }
    let(:union) { Algebra::Union.new(left, right) }

    it { should equal(union) }

    it 'yields the union' do
      expect { subject }.to change { yields.dup }.from([]).to([ [ 1 ], [ 2 ] ])
    end
  end
end
