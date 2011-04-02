require 'spec_helper'

describe Relation::Operation::Offset, '#each' do
  subject { object.each { |tuple| yields << tuple } }

  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ]) }
  let(:order)    { relation.order                                              }
  let(:object)   { described_class.new(order, 1)                               }
  let(:yields)   { []                                                          }

  it_should_behave_like 'a command method'

  it 'yields each tuple' do
    expect { subject }.to change { yields.dup }.
      from([]).
      to([ [ 2 ], [ 3 ] ])
  end
end
