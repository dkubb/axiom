require 'spec_helper'

describe Relation::Operation::Reverse, '#each' do
  subject { object.each { |tuple| yields << tuple } }

  let(:klass)    { Relation::Operation::Reverse                                }
  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ]) }
  let(:order)    { relation.order                                              }
  let(:object)   { klass.new(order)                                            }
  let(:yields)   { []                                                          }

  it_should_behave_like 'a command method'

  it 'yields each tuple in reverse order' do
    expect { subject }.to change { yields.dup }.
      from([]).
      to([ [ 3 ], [ 2 ], [ 1 ] ])
  end
end
