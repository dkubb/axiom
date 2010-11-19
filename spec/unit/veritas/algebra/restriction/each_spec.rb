require 'spec_helper'

describe 'Veritas::Algebra::Restriction#each' do
  subject { object.each { |tuple| yields << tuple } }

  let(:klass)    { Algebra::Restriction                          }
  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:object)   { klass.new(relation, proc { true })            }
  let(:yields)   { []                                            }

  it_should_behave_like 'a command method'

  it 'yields each tuple' do
    expect { subject }.to change { yields.dup }.
      from([]).
      to([ [ 1 ] ])
  end
end
