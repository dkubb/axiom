# encoding: utf-8

require 'spec_helper'

describe Algebra::Intersection, '#each' do
  subject { object.each { |tuple| yields << tuple } }

  let(:object) { described_class.new(left, right) }
  let(:left)   { Relation.new(header, [ [ 1 ] ])  }
  let(:header) { [ [ :id, Integer ] ]             }
  let(:yields) { []                               }

  context 'with relations having similar bodies' do
    let(:right) { left.dup }

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
        to([ [ 1 ] ])
    end
  end

  context 'with relations having different bodies' do
    let(:right) { Relation.new(header, [ [ 2 ] ]) }

    it_should_behave_like 'an #each method'

    it 'yields no tuples' do
      subject
      yields.should be_empty
    end
  end
end
