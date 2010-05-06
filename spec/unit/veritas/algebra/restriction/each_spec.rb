require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction#each' do
  let(:relation)    { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])     }
  let(:restriction) { Algebra::Restriction.new(relation, proc { true }) }
  let(:yields)      { []                                                }

  subject { restriction.each { |tuple| yields << tuple } }

  it { should equal(restriction) }

  it 'yields each tuple' do
    method(:subject).should change { yields.dup }.from([]).to([ [ 1 ] ])
  end
end
