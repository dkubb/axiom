# encoding: utf-8

require 'bigdecimal'
require 'date'
require 'set'
require 'singleton'

require 'adamantium'
require 'backports'
require 'backports/basic_object' unless defined?(::BasicObject)
require 'equalizer'

require 'veritas/core_ext/date'
require 'veritas/core_ext/range'
require 'veritas/core_ext/time'

require 'veritas/support/abstract_class'
require 'veritas/support/aliasable'
require 'veritas/support/visitable'

require 'veritas/support/equalizer'
require 'veritas/support/evaluator'

require 'veritas/support/operation/binary'
require 'veritas/support/operation/unary'

require 'veritas/aggregate'
require 'veritas/aggregate/count'
require 'veritas/aggregate/maximum'
require 'veritas/aggregate/mean'
require 'veritas/aggregate/minimum'
require 'veritas/aggregate/sum'
require 'veritas/aggregate/variance'
require 'veritas/aggregate/standard_deviation'

require 'veritas/function'
require 'veritas/function/binary'
require 'veritas/function/unary'
require 'veritas/function/comparable'

require 'veritas/function/connective'
require 'veritas/function/connective/conjunction'
require 'veritas/function/connective/disjunction'
require 'veritas/function/connective/negation'

require 'veritas/function/predicate'
require 'veritas/function/predicate/enumerable'
require 'veritas/function/predicate/equality'
require 'veritas/function/predicate/exclusion'
require 'veritas/function/predicate/greater_than'
require 'veritas/function/predicate/greater_than_or_equal_to'
require 'veritas/function/predicate/inclusion'
require 'veritas/function/predicate/inequality'
require 'veritas/function/predicate/less_than'
require 'veritas/function/predicate/less_than_or_equal_to'
require 'veritas/function/predicate/no_match'
require 'veritas/function/predicate/match'

require 'veritas/function/proposition'
require 'veritas/function/proposition/contradiction'
require 'veritas/function/proposition/tautology'

require 'veritas/relation'

require 'veritas/relation/proxy'

require 'veritas/relation/base'
require 'veritas/relation/header'

require 'veritas/relation/materialized'
require 'veritas/relation/empty'

require 'veritas/relation/operation/unary'
require 'veritas/relation/operation/binary'
require 'veritas/relation/operation/combination'
require 'veritas/relation/operation/set'
require 'veritas/relation/operation/offset'
require 'veritas/relation/operation/order'
require 'veritas/relation/operation/order/direction'
require 'veritas/relation/operation/order/direction_set'
require 'veritas/relation/operation/limit'
require 'veritas/relation/operation/reverse'

require 'veritas/algebra/difference'
require 'veritas/algebra/extension'
require 'veritas/algebra/intersection'
require 'veritas/algebra/join'
require 'veritas/algebra/product'
require 'veritas/algebra/projection'
require 'veritas/algebra/rename'
require 'veritas/algebra/rename/aliases'
require 'veritas/algebra/restriction'
require 'veritas/algebra/summarization'
require 'veritas/algebra/summarization/summaries'
require 'veritas/algebra/summarization/summary'
require 'veritas/algebra/union'

require 'veritas/relation/operation/deletion'
require 'veritas/relation/operation/insertion'

require 'veritas/attribute/comparable'

require 'veritas/attribute'
require 'veritas/attribute/object'
require 'veritas/attribute/numeric'
require 'veritas/attribute/boolean'
require 'veritas/attribute/class'
require 'veritas/attribute/date'
require 'veritas/attribute/date_time'
require 'veritas/attribute/decimal'
require 'veritas/attribute/float'
require 'veritas/attribute/integer'
require 'veritas/attribute/time'
require 'veritas/attribute/string'

require 'veritas/function/numeric'
require 'veritas/function/numeric/binary'
require 'veritas/function/numeric/unary'

require 'veritas/function/numeric/absolute'
require 'veritas/function/numeric/addition'
require 'veritas/function/numeric/division'
require 'veritas/function/numeric/exponentiation'
require 'veritas/function/numeric/modulo'
require 'veritas/function/numeric/multiplication'
require 'veritas/function/numeric/square_root'
require 'veritas/function/numeric/subtraction'
require 'veritas/function/numeric/unary_minus'
require 'veritas/function/numeric/unary_plus'

require 'veritas/function/string/length'

require 'veritas/tuple'
require 'veritas/version'

module Veritas

  # Raised when the headers are invalid for Join and Product
  class InvalidHeaderError < ArgumentError; end

  # Raised when the aliases are duplicated
  class DuplicateAliasError < ArgumentError; end

  # Raised when the limit is not a positive integer
  class InvalidLimitError < ArgumentError; end

  # Raised when the offset is not a positive integer
  class InvalidOffsetError < ArgumentError; end

  # Raised when the order does not include every attribute in the header
  class InvalidDirectionsError < ArgumentError; end

  # Raised when a method requiring ordering is called on an unordered relation
  class OrderedRelationRequiredError < StandardError; end

  # Raised when a binary operation mixes ordered and unordered relations
  class RelationMismatchError < StandardError; end

  # Raised when a name is a duplicate of another name in a set
  class DuplicateNameError < StandardError; end

  # Raised when the attribute is unknown
  class UnknownAttributeError < IndexError; end

  # Raised when a relation insertion or deletion fails
  class WriteError < StandardError; end

  # Raised when inserting into a projection that removes required attributes
  class RequiredAttributesError < WriteError; end

  # Raised when inserting into an extension with a mismatching relation
  class ExtensionMismatchError < WriteError; end

  # Raised when inserting into an order with a mismatching relation
  class OrderMismatchError < WriteError; end

  # Raised when inserting into an immutable relation
  class ImmutableRelationError < WriteError; end

  # Raised when the set size is unexpected
  class SetSizeError < RuntimeError; end

  # Raised when the set is unexpectedly empty
  class NoTuplesError < SetSizeError; end

  # Raised when the set is unexpectedly too large
  class ManyTuplesError < SetSizeError; end

  # Represent an undefined argument
  Undefined = Object.new.freeze

  # Represent a relation with an empty header and no tuples
  TABLE_DUM = Relation::Empty.new([])

  # Represent a relation with an empty header and a single tuple
  TABLE_DEE = Relation.new([], [ [] ])

  # Error message constants for inserted and deleted messages
  INSERTED = 'inserted'.freeze
  DELETED  = 'deleted'.freeze
end
