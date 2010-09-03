require 'spec_helper'

describe 'Veritas::Algebra::Projection#each' do
  subject { object.each { |tuple| yields << tuple } }

  let(:klass)    { Algebra::Projection                                         }
  let(:body)     { [ [ 1, 'Dan Kubb' ], [ 2, 'Dan Kubb' ], [ 2, 'Alex Kubb'] ] }
  let(:relation) { Relation.new([ [ :id, Integer ], [ :name, String ] ], body) }
  let(:object)   { klass.new(relation, [ :id ])                                }
  let(:yields)   { []                                                          }

  it { should equal(object) }

  it 'yields each tuple only once' do
    expect { subject }.to change { yields.dup }.from([]).to([ [ 1 ], [ 2 ] ])
  end
end
