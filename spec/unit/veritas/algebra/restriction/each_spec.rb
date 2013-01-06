# encoding: utf-8

require 'spec_helper'

describe Algebra::Restriction, '#each' do
  subject { object.each { |tuple| yields << tuple } }

  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:object)   { described_class.new(relation, predicate)      }
  let(:yields)   { []                                            }

  context 'when predicate is a Proc' do
    let(:predicate) { proc { true } }

    it_should_behave_like 'an #each method'

    it 'yields each tuple' do
      expect { subject }.to change { yields.dup }.
        from([]).
        to([ [ 1 ] ])
    end
  end

  context 'when predicate is a Function' do
    let(:predicate) { Function::Proposition::Tautology.instance }

    it_should_behave_like 'an #each method'

    it 'yields each tuple' do
      expect { subject }.to change { yields.dup }.
        from([]).
        to([ [ 1 ] ])
    end
  end

  context 'when predicate is a value equal to true' do
    let(:predicate) { true }

    it_should_behave_like 'an #each method'

    it 'yields each tuple' do
      expect { subject }.to change { yields.dup }.
        from([]).
        to([ [ 1 ] ])
    end
  end

  context 'when predicate is a value not equal to true' do
    let(:predicate) { 1 }

    it_should_behave_like 'an #each method'

    it 'yields each tuple' do
      expect { subject }.to_not change { yields.dup }
    end
  end
end
