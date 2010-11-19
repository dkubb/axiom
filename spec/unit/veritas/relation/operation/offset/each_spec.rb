require 'spec_helper'

describe 'Veritas::Relation::Operation::Offset#each' do
  subject { object.each { |tuple| yields << tuple } }

  let(:klass)    { Relation::Operation::Offset                                 }
  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ]) }
  let(:order)    { relation.order                                              }
  let(:object)   { klass.new(order, 1)                                         }
  let(:yields)   { []                                                          }

  it_should_behave_like 'a command method'

  it 'yields each tuple' do
    expect { subject }.to change { yields.dup }.
      from([]).
      to([ [ 2 ], [ 3 ] ])
  end
end
