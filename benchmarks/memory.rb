#!/usr/bin/env ruby -Ku

# encoding: utf-8

# benchmark memory usage of lib, core object init and relation operations

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'backports'
require 'backports/basic_object'

unless GC.respond_to?(:enable_stats)
  puts 'Error: benchmark works on ree, or ruby with Railsbench GC patch only'
  exit 1
end

COUNTS    = [ 1, 10, 100, 1_000, 10_000, 100_000 ].freeze
NAME      = 'Dan Kubb'.freeze
RELATIONS = {}

# original code from http://blog.pluron.com/2008/02/memory-profilin.html
def gc_statistics(description = '', options = {})
  GC.enable_stats || GC.clear_stats
  GC.disable if options[:disable_gc]

  yield

  stat_string = "#{description}: "
  stat_string += "allocated: #{GC.allocated_size} bytes total in #{GC.num_allocations} allocations, "
  stat_string += "GC calls: #{GC.collections}, "
  stat_string += "GC time: #{GC.time}"

  GC.log stat_string
  GC.dump if options[:show_gc_dump]

  GC.enable if options[:disable_gc]
  GC.disable_stats
end

puts '-' * 80
gc_statistics 'veritas lib' do
  require 'veritas'
end

include Veritas

puts '-' * 80
gc_statistics 'header' do
  HEADER = Relation::Header.new([ [ :id, Integer ], [ :name, String ] ])
end

puts '-' * 80
gc_statistics 'tuple' do
  TUPLE = Tuple.new(HEADER, [ 1, NAME ])
end

puts '-' * 80
gc_statistics 'relation' do
  Relation.new(HEADER, Tuple.new(HEADER, TUPLE))
end

# pre-allocate all the relations for the preceding operations
COUNTS.each do |count|
  RELATIONS[count] = Relation.new(
    HEADER,
    (1..count).map { |n| Tuple.new(HEADER, [ n, NAME ]) }
  )
end

def each_count
  puts '-' * 80
  COUNTS.each do |count|
    relation = RELATIONS[count].dup
    yield(relation.to_a, relation, count)
  end
end

each_count do |array, relation, count|
  gc_statistics "enumeration (#{count} tuples)" do
    relation.each {}
  end
end

each_count do |array, relation, count|
  gc_statistics "projection (#{count} tuples)" do
    relation.project([ :id ]).each {}
  end
end

each_count do |array, relation, count|
  gc_statistics "removal (#{count} tuples)" do
    relation.remove([ :name ]).each {}
  end
end

each_count do |array, relation, count|
  gc_statistics "restriction (#{count} tuples)" do
    relation.restrict { |r| r[:id].gte(1) }.each {}
  end
end

each_count do |array, relation, count|
  gc_statistics "join (#{count} tuples)" do
    relation.join(Relation.new([ [ :id, Integer, ], [ :age, Integer ] ], [ [ 1, 35 ] ])).each {}
  end
end

each_count do |array, relation, count|
  gc_statistics "product (#{count} tuples)" do
    relation.product(Relation.new([ [ :age, Integer ] ], [ [ 35 ] ])).each {}
  end
end

each_count do |array, relation, count|
  gc_statistics "intersection (#{count} tuples)" do
    relation.intersect(relation).each {}
  end
end

each_count do |array, relation, count|
  gc_statistics "union (#{count} tuples)" do
    relation.union(relation).each {}
  end
end

each_count do |array, relation, count|
  gc_statistics "difference (#{count} tuples)" do
    relation.difference(relation).each {}
  end
end

each_count do |array, relation, count|
  gc_statistics "order (#{count} tuples)" do
    relation.sort_by { |r| [ r[:id].desc, r[:name] ] }.each {}
  end
end

each_count do |array, relation, count|
  relation = relation.sort_by { |r| [ r[:id], r[:name] ] }

  gc_statistics "take (#{count} tuples)" do
    relation.take(count).each {}
  end
end

each_count do |array, relation, count|
  relation = relation.sort_by { |r| [ r[:id], r[:name] ] }

  gc_statistics "drop (#{count} tuples)" do
    relation.drop(1).each {}
  end
end

each_count do |array, relation, count|
  relation = relation.sort_by { |r| [ r[:id], r[:name] ] }

  gc_statistics "first (#{count} tuples)" do
    relation.first(count).each {}
  end
end

each_count do |array, relation, count|
  relation = relation.sort_by { |r| [ r[:id], r[:name] ] }

  gc_statistics "last (#{count} tuples)" do
    relation.last(count).each {}
  end
end

each_count do |array, relation, count|
  relation = relation.sort_by { |r| [ r[:id], r[:name] ] }

  gc_statistics "reverse (#{count} tuples)" do
    relation.reverse.each {}
  end
end
