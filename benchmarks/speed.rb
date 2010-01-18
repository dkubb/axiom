#!/usr/bin/env ruby -Ku

# benchmark speed of relation operations

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'rbench'
require 'veritas'
include Veritas

TIMES  = 1
COUNTS = [ 1, 10, 100, 1_000, 10_000, 100_000 ].freeze
NAME   = 'Dan Kubb'.freeze
HEADER = Relation::Header.new([ [ :id, Integer ], [ :name, String ] ])

RELATIONS = {}

COUNTS.each do |count|
  RELATIONS[count] = Relation.new(
    HEADER,
    (1..count).map { |n| Tuple.new(HEADER, [ n, NAME ]) }
  )
end

def each_count
  COUNTS.each do |count|
    relation = RELATIONS[count].dup
    yield(relation.to_a, relation, count)
  end
end

RBench.run(TIMES) do
  column :ruby,    :title => 'Ruby'
  column :veritas, :title => 'Veritas'
  column :diff,    :title => 'Diff', :compare => [ :ruby, :veritas ]

  each_count do |array, relation, count|
    report "enumeration (#{count} tuples)" do
      ruby    { array.each {} }
      veritas { relation.each {} }
    end
  end

  each_count do |array, relation, count|
    report "projection (#{count} tuples)" do
      ruby    { array.map { |tuple| [ tuple[:id] ] }.each {} }
      veritas { relation.project([ :id ]).each {} }
    end
  end

  each_count do |array, relation, count|
    report "removal (#{count} tuples)" do
      ruby    { array.map { |tuple| [ tuple[:id] ] }.each {} }
      veritas { relation.remove([ :name ]).each {} }
    end
  end

  each_count do |array, relation, count|
    report "restriction (#{count} tuples)" do
      ruby    { array.select { |tuple| tuple[:id] >= 1 }.each {} }
      veritas { relation.restrict { |r| r[:id].gte(1) }.each {} }
    end
  end

  each_count do |array, relation, count|
    report "join (#{count} tuples)" do
      veritas { relation.join(Relation.new([ [ :id, Integer, ], [ :age, Integer ] ], [ [ 1, 34 ] ])).each {} }
    end
  end

  each_count do |array, relation, count|
    report "product (#{count} tuples)" do
#      ruby    { array.product(array).each {} }  # uses too much memory and crashes
      veritas { relation.product(Relation.new([ [ :age, Integer ] ], [ [ 34 ] ])).each {} }
    end
  end

  each_count do |array, relation, count|
    report "intersection (#{count} tuples)" do
      ruby    { (array & array).each {} }
      veritas { relation.intersect(relation).each {} }
    end
  end

  each_count do |array, relation, count|
    report "union (#{count} tuples)" do
      ruby    { (array | array).each {} }
      veritas { relation.union(relation).each {} }
    end
  end

  each_count do |array, relation, count|
    report "difference (#{count} tuples)" do
      ruby    { (array - array).each {} }
      veritas { relation.difference(relation).each {} }
    end
  end

  each_count do |array, relation, count|
    report "order (#{count} tuples)" do
      ruby    { array.sort_by { |tuple| [ -tuple[:id], tuple[:name] ] }.each {} }
      veritas { relation.order { |r| [ r[:id].desc, r[:name] ] }.each {} }
    end
  end

  each_count do |array, relation, count|
    relation = relation.order(relation.header)

    report "limit (#{count} tuples)" do
      ruby    { array.take(count).each {} }
      veritas { relation.limit(count).each {} }
    end
  end

  each_count do |array, relation, count|
    relation = relation.order(relation.header)

    report "offset (#{count} tuples)" do
      ruby    { array.drop(1).each {} }
      veritas { relation.offset(1).each {} }
    end
  end

  each_count do |array, relation, count|
    relation = relation.order(relation.header)

    report "first (#{count} tuples)" do
      ruby    { array.first(count).each {} }
      veritas { relation.first(count).each {} }
    end
  end

  each_count do |array, relation, count|
    relation = relation.order(relation.header)

    report "last (#{count} tuples)" do
      ruby    { array.last(count).each {} }
      veritas { relation.last(count).each {} }
    end
  end

  each_count do |array, relation, count|
    relation = relation.order(relation.header)

    report "reverse (#{count} tuples)" do
      ruby    { array.reverse.each {} }
      veritas { relation.reverse.each {} }
    end
  end
end
