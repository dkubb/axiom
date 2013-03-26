#!/usr/bin/env ruby -Ku

# encoding: utf-8

# benchmark speed of relation operations

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'rbench'
require 'axiom'
include Axiom

TIMES = 5_000

header   = Relation::Header.new([ [ :id, Integer ], [ :name, String ] ])
array    = (1..100).map { |n| Tuple.new(header, [ n, 'Dan Kubb' ]) }
relation = Relation.new(header, array)
join     = Relation.new([ [ :id, Integer, ], [ :age, Integer ] ], [ [ 1, 35 ] ])
product  = Relation.new([ [ :age, Integer ] ], [ [ 35 ] ])
ordered  = relation.sort_by { |r| [ r.id, r.name ] }

RBench.run(TIMES) do
  column :ruby,  :title => 'Ruby'
  column :axiom, :title => 'Axiom'
  column :diff,  :title => 'Diff', :compare => [ :ruby, :axiom ]

  report 'each' do
    ruby  { array.each {}    }
    axiom { relation.each {} }
  end

  report 'projection' do
    ruby  { array.map { |tuple| [ tuple[:id] ] }.each {} }
    axiom { relation.project([ :id ]).each {}            }
  end

  report 'removal' do
    ruby  { array.map { |tuple| [ tuple[:id] ] }.each {} }
    axiom { relation.remove([ :name ]).each {}           }
  end

  report 'restriction' do
    ruby  { array.select { |tuple| tuple[:id] >= 1 }.each {} }
    axiom { relation.restrict { |r| r.id.gte(1) }.each {}    }
  end

  report 'join' do
    axiom { relation.join(join).each {} }
  end

  report 'product' do
    ruby  { array.product(array).each {}      }
    axiom { relation.product(product).each {} }
  end

  report 'intersection' do
    ruby  { (array & array).each {}              }
    axiom { relation.intersect(relation).each {} }
  end

  report 'union' do
    ruby  { (array | array).each {}          }
    axiom { relation.union(relation).each {} }
  end

  report 'difference' do
    ruby  { (array - array).each {}               }
    axiom { relation.difference(relation).each {} }
  end

  report 'order' do
    ruby  { array.sort_by { |tuple| [ -tuple[:id], tuple[:name] ] }.each {} }
    axiom { relation.sort_by { |r| [ r.id.desc, r.name ] }.each {}          }
  end

  report 'take' do
    ruby  { array.take(1).each {}   }
    axiom { ordered.take(1).each {} }
  end

  report 'drop' do
    ruby  { array.drop(1).each {}   }
    axiom { ordered.drop(1).each {} }
  end

  report 'first' do
    ruby  { array.first(1).each {}   }
    axiom { ordered.first(1).each {} }
  end

  report 'last' do
    ruby  { array.last(1).each {}   }
    axiom { ordered.last(1).each {} }
  end

  report 'reverse' do
    ruby  { array.reverse.each {}   }
    axiom { ordered.reverse.each {} }
  end
end
