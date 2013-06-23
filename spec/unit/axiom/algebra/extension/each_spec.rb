# encoding: utf-8

require 'spec_helper'

describe Algebra::Extension, '#each' do
  subject { object.each { |tuple| yields << tuple } }

  let(:object)     { described_class.new(operand, extensions)             }
  let(:operand)    { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ]) }
  let(:extensions) { { test: lambda { |tuple| 1 } }                       }
  let(:yields)     { []                                                   }

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
      to([ [ 1, 1 ], [ 2, 1 ] ])
  end
end
