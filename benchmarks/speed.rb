#!/usr/bin/env ruby -Ku

# encoding: utf-8

# benchmark speed of relation operations

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'backports'
require 'rbench'
require 'veritas'
include Veritas

TIMES = 5_000

header   = Relation::Header.new([ [ :id, Integer ], [ :name, String ] ])
array    = (1..100).map { |n| Tuple.new(header, [ n, 'Dan Kubb' ]) }
relation = Relation.new(header, array)
join     = Relation.new([ [ :id, Integer, ], [ :age, Integer ] ], [ [ 1, 35 ] ])
product  = Relation.new([ [ :age, Integer ] ], [ [ 35 ] ])
ordered  = relation.order(relation.header)

RBench.run(TIMES) do
  column :ruby,    :title => 'Ruby'
  column :veritas, :title => 'Veritas'
  column :diff,    :title => 'Diff', :compare => [ :ruby, :veritas ]

  report 'each' do
    ruby    { array.each {}    }
    veritas { relation.each {} }
  end

  report 'projection' do
    ruby    { array.map { |tuple| [ tuple[:id] ] }.each {} }
    veritas { relation.project([ :id ]).each {}            }
  end

  report 'removal' do
    ruby    { array.map { |tuple| [ tuple[:id] ] }.each {} }
    veritas { relation.remove([ :name ]).each {}           }
  end

  report 'restriction' do
    ruby    { array.select { |tuple| tuple[:id] >= 1 }.each {} }
    veritas { relation.restrict { |r| r[:id].gte(1) }.each {}  }
  end

  report 'join' do
    veritas { relation.join(join).each {} }
  end

  report 'product' do
    ruby    { array.product(array).each {}      }
    veritas { relation.product(product).each {} }
  end

  report 'intersection' do
    ruby    { (array & array).each {}              }
    veritas { relation.intersect(relation).each {} }
  end

  report 'union' do
    ruby    { (array | array).each {}          }
    veritas { relation.union(relation).each {} }
  end

  report 'difference' do
    ruby    { (array - array).each {}               }
    veritas { relation.difference(relation).each {} }
  end

  report 'order' do
    ruby    { array.sort_by { |tuple| [ -tuple[:id], tuple[:name] ] }.each {} }
    veritas { relation.order { |r| [ r[:id].desc, r[:name] ] }.each {}        }
  end

  report 'take' do
    ruby    { array.take(1).each {}   }
    veritas { ordered.take(1).each {} }
  end

  report 'drop' do
    ruby    { array.drop(1).each {}   }
    veritas { ordered.drop(1).each {} }
  end

  report 'first' do
    ruby    { array.first(1).each {}   }
    veritas { ordered.first(1).each {} }
  end

  report 'last' do
    ruby    { array.last(1).each {}   }
    veritas { ordered.last(1).each {} }
  end

  report 'reverse' do
    ruby    { array.reverse.each {}   }
    veritas { ordered.reverse.each {} }
  end
end
