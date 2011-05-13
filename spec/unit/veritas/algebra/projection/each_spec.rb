# encoding: utf-8

require 'spec_helper'

describe Algebra::Projection, '#each' do
  subject { object.each { |tuple| yields << tuple } }

  let(:body)     { [ [ 1, 'Dan Kubb' ], [ 2, 'Dan Kubb' ], [ 2, 'Alex Kubb'] ] }
  let(:relation) { Relation.new([ [ :id, Integer ], [ :name, String ] ], body) }
  let(:object)   { described_class.new(relation, [ :id ])                      }
  let(:yields)   { []                                                          }

  it_should_behave_like 'an #each method'

  it 'yields each tuple' do
    expect { subject }.to change { yields.dup }.
      from([]).
      to([ [ 1 ], [ 2 ] ])
  end
end
