# encoding: utf-8

require 'spec_helper'

describe Algebra::Restriction, '#each' do
  subject { object.each { |tuple| yields << tuple } }

  let(:object)   { described_class.new(relation, predicate)      }
  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:yields)   { []                                            }

  context 'when predicate is a Proc' do
    let(:predicate) { proc { true } }

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

  context 'when predicate is a Function' do
    let(:predicate) { Function::Proposition::Tautology.instance }

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

  context 'when predicate is a value equal to true' do
    let(:predicate) { true }

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

  context 'when predicate is a value not equal to true' do
    let(:predicate) { 1 }

    it_should_behave_like 'an #each method'

    it 'yields no tuples' do
      subject
      yields.should be_empty
    end
  end
end
