require 'spec_helper'

describe 'Veritas::Relation::Operation::Order#each' do
  subject { object.each { |tuple| yields << tuple } }

  let(:klass)      { Relation::Operation::Order                                  }
  let(:relation)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ]) }
  let(:directions) { [ relation[:id].desc ]                                      }
  let(:object)     { klass.new(relation, directions)                             }
  let(:yields)     { []                                                          }

  it_should_behave_like 'a command method'

  it 'yields each tuple in order' do
    expect { subject }.to change { yields.dup }.
      from([]).
      to([ [ 3 ], [ 2 ], [ 1 ] ])
  end
end
