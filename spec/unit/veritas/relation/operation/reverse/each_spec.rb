# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Reverse, '#each' do
  subject { object.each { |tuple| yields << tuple } }

  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ]) }
  let(:order)    { relation.sort_by { |r| r[:id] }                             }
  let(:object)   { described_class.new(order)                                  }
  let(:yields)   { []                                                          }

  it_should_behave_like 'an #each method'

  it 'yields each tuple in reverse order' do
    expect { subject }.to change { yields.dup }.
      from([]).
      to([ [ 3 ], [ 2 ], [ 1 ] ])
  end
end
