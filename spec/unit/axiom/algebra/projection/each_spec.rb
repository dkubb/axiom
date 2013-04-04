# encoding: utf-8

require 'spec_helper'

describe Algebra::Projection, '#each' do
  subject { object.each { |tuple| yields << tuple } }

  let(:object)   { described_class.new(relation, [ :id ])                      }
  let(:relation) { Relation.new([ [ :id, Integer ], [ :name, String ] ], body) }
  let(:body)     { [ [ 1, 'Dan Kubb' ], [ 2, 'Dan Kubb' ], [ 2, 'Alex Kubb'] ] }
  let(:yields)   { []                                                          }

  it_should_behave_like 'an #each method'

  it 'yields only tuples' do
    subject
    yields.each { |tuple| tuple.should be_instance_of(Tuple) }
  end

  it 'yields only tuples with the expected header' do
    subject
    yields.each { |tuple| tuple.header.should be(object.header) }
  end

  it 'yields only tuples with the expected data' do
    expect { subject }.to change { yields.dup }.
      from([]).
      to([ [ 1 ], [ 2 ] ])
  end
end
