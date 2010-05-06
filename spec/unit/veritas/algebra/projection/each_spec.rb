require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Projection#each' do
  let(:relation) do
    Relation.new(
      [ [ :id, Integer ], [ :name, String ] ],
      [
        [ 1, 'Dan Kubb' ],
        [ 2, 'Dan Kubb' ],
        [ 2, 'Alex Kubb'],
      ]
    )
  end

  let(:header)     { relation.header.project([ :id ])          }
  let(:projection) { Algebra::Projection.new(relation, header) }
  let(:yields)     { []                                        }

  subject { projection.each { |tuple| yields << tuple } }

  it { should equal(projection) }

  it 'yields each tuple only once' do
    method(:subject).should change { yields.dup }.from([]).to([ [ 1 ], [ 2 ] ])
  end
end
