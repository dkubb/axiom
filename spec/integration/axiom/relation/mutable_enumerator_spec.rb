# encoding: utf-8

require 'spec_helper'

# Test that tuple enumerators are not frozen

class MutableEnumerator < Enumerator
  attr_reader :mutable_array

  def initialize(tuples)
    @mutable_array = []
    super() do |yielder|
      tuples.each do |tuple|
        @mutable_array << tuple
        yielder << tuple
      end
    end
  end
end

describe Relation do
  context 'with a tuple enumerator' do
    let(:relation)   { Relation.new([ [ :id, Integer ] ], enumerator) }
    let(:enumerator) { MutableEnumerator.new(tuples)                  }
    let(:tuples)     { [ [ 1 ], [ 2 ] ]                               }

    context 'when the enumerator is materialized' do
      it 'does not freeze the enumerator' do
        expect { relation.materialize }.
          to_not change(enumerator, :frozen?).from(false)
      end

      it 'allows the array to be mutated' do
        expect { relation.materialize }.
          to change(enumerator, :mutable_array).from([]).to(tuples)
      end
    end

    context 'when the enumerator is materialized and restricted' do
      it 'does not freeze the enumerator' do
        expect { relation.restrict(id: 1).materialize }.
          to_not change(enumerator, :frozen?).from(false)
      end

      it 'allows the array to be mutated' do
        expect { relation.restrict(id: 1).materialize }.
          to change(enumerator, :mutable_array).from([]).to(tuples)
      end
    end
  end
end
