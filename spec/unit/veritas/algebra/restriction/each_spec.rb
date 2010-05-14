require 'spec_helper'

describe 'Veritas::Algebra::Restriction#each' do
  subject { restriction.each { |tuple| yields << tuple } }

  let(:relation)    { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])     }
  let(:restriction) { Algebra::Restriction.new(relation, proc { true }) }
  let(:yields)      { []                                                }

  it { should equal(restriction) }

  it 'yields each tuple' do
    method(:subject).should change { yields.dup }.from([]).to([ [ 1 ] ])
  end
end
