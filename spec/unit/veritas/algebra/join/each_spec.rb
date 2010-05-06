require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Join#each' do
  let(:left)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ])                         }
  let(:right)  { Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 2, 'Dan Kubb' ] ]) }
  let(:join)   { Algebra::Join.new(left, right)                                               }
  let(:yields) { []                                                                           }

  subject { join.each { |tuple| yields << tuple } }

  it { should equal(join) }

  it 'yields the join' do
    method(:subject).should change { yields.dup }.
      from([]).
      to([ [ 2, 'Dan Kubb' ] ])
  end
end
