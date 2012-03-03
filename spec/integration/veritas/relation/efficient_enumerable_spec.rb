# encoding: utf-8

require 'spec_helper'
require 'timeout'

# use an infinite list to simulate handling a large Array.
# if any operation is inefficient, then the specs will never exit
class InfiniteList
  include Enumerable

  def each(&block)
    0.upto(Float::INFINITY) { |index| yield [ index ] }
    self
  end
end

describe Relation do
  context 'Efficient Enumerable operation' do
    let(:relation) { Relation.new([ [ :id, Integer ] ], InfiniteList.new) }

    def sample(relation)
      Timeout.timeout(1) do
        relation.to_enum.take(5)
      end
    end

    it '#project should be efficient' do
      projected = relation.project([ :id ])
      sample(projected).should == [ [ 0 ], [ 1 ], [ 2 ], [ 3 ], [ 4 ] ]
    end

    it '#restrict should be efficient' do
      restricted = relation.restrict{ |r| r.id.gt(5) }
      sample(restricted).should == [ [ 6 ], [ 7 ], [ 8 ], [ 9 ], [ 10 ] ]
    end

    it '#rename should be efficient' do
      renamed = relation.rename(:id => :other_id)
      sample(renamed).should == [ [ 0 ], [ 1 ], [ 2 ], [ 3 ], [ 4 ] ]
    end

    describe '#join should be efficient' do
      let(:other) { Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 1, 'Dan Kubb' ] ]) }

      it 'has an infinite left relation' do
        pending 'Change #join to handle infinite sets'
        join = other.join(relation)
        sample(join).should == [ [ 1, 'Dan Kubb' ] ]
      end

      it 'has an infinite right relation' do
        pending 'Change #join to handle infinite sets'
        join = relation.join(other)
        sample(join).should == [ [ 1, 'Dan Kubb' ] ]
      end
    end

    describe '#product should be efficient' do
      let(:other) { Relation.new([ [ :name, String ] ], [ [ 'Dan Kubb' ] ]) }

      it 'has an infinite left relation' do
        product = relation.product(other)
        sample(product).should == [ [ 0, 'Dan Kubb' ], [ 1, 'Dan Kubb' ], [ 2, 'Dan Kubb' ], [ 3, 'Dan Kubb' ], [ 4, 'Dan Kubb' ] ]
      end

      it 'has an infinite right relation' do
        pending do
          product = other.product(relation)
          sample(product).should == [ [ 0, 'Dan Kubb' ], [ 1, 'Dan Kubb' ], [ 2, 'Dan Kubb' ], [ 3, 'Dan Kubb' ], [ 4, 'Dan Kubb' ] ]
        end
      end
    end

    it '#difference should be efficient' do
      difference = relation.difference(Relation.new(relation.header, [ [ 1 ] ]))
      sample(difference).should == [ [ 0 ], [ 2 ], [ 3 ], [ 4 ], [ 5 ] ]
    end

    it '#union should be efficient' do
      union = relation.union(Relation.new(relation.header, [ [ 1 ] ]))
      sample(union).should == [ [ 0 ], [ 1 ], [ 2 ], [ 3 ], [ 4 ] ]
    end
  end
end
