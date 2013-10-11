# encoding: utf-8

require 'bigdecimal'
require 'date'
require 'set'
require 'singleton'

require 'abstract_type'
require 'adamantium'
require 'descendants_tracker'
require 'equalizer'

module Axiom

  # Raised when the headers are invalid for Join and Product
  class InvalidHeaderError < ArgumentError; end

  # Raised when the aliases are duplicated
  class DuplicateAliasError < ArgumentError; end

  # Raised when the limit is not a positive integer
  class InvalidLimitError < ArgumentError; end

  # Raised when the offset is not a positive integer
  class InvalidOffsetError < ArgumentError; end

  # Raised when a method requiring ordering is called on an unordered relation
  class OrderedRelationRequiredError < StandardError; end

  # Raised when a binary operation mixes ordered and unordered relations
  class RelationMismatchError < StandardError; end

  # Raised when a name is a duplicate of another name in a set
  class DuplicateNameError < ArgumentError; end

  # Raised when the attribute is unknown
  class UnknownAttributeError < IndexError; end

  # Raised when the key is reducible
  class ReducibleKeyError < ArgumentError; end

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

  # An empty Hash to use as for default options
  EMPTY_HASH = {}.freeze

  # An empty Array to use for a default value
  EMPTY_ARRAY = [].freeze

  # Error message constants for inserted and deleted messages
  INSERTED = 'inserted'.freeze
  DELETED  = 'deleted'.freeze
end # module Axiom

require 'axiom/core_ext/date'
require 'axiom/core_ext/range'
require 'axiom/core_ext/time'

require 'axiom/support/aliasable'
require 'axiom/support/visitable'

require 'axiom/support/equalizer'
require 'axiom/support/evaluator'

require 'axiom/support/operation/binary'
require 'axiom/support/operation/unary'

require 'axiom/function'
require 'axiom/function/binary'
require 'axiom/function/unary'
require 'axiom/function/comparable'

require 'axiom/function/connective'
require 'axiom/function/connective/conjunction'
require 'axiom/function/connective/disjunction'
require 'axiom/function/connective/negation'

require 'axiom/function/predicate'
require 'axiom/function/predicate/enumerable'
require 'axiom/function/predicate/equality'
require 'axiom/function/predicate/exclusion'
require 'axiom/function/predicate/greater_than'
require 'axiom/function/predicate/greater_than_or_equal_to'
require 'axiom/function/predicate/inclusion'
require 'axiom/function/predicate/inequality'
require 'axiom/function/predicate/less_than'
require 'axiom/function/predicate/less_than_or_equal_to'
require 'axiom/function/predicate/no_match'
require 'axiom/function/predicate/match'

require 'axiom/function/proposition'
require 'axiom/function/proposition/contradiction'
require 'axiom/function/proposition/tautology'

require 'axiom/aggregate'
require 'axiom/aggregate/count'
require 'axiom/aggregate/maximum'
require 'axiom/aggregate/mean'
require 'axiom/aggregate/minimum'
require 'axiom/aggregate/sum'
require 'axiom/aggregate/variance'
require 'axiom/aggregate/standard_deviation'

require 'axiom/relation'

require 'axiom/relation/proxy'

require 'axiom/relation/keys'
require 'axiom/relation/header'
require 'axiom/relation/index'

require 'axiom/relation/base'
require 'axiom/relation/variable'

require 'axiom/relation/materialized'
require 'axiom/relation/empty'

require 'axiom/relation/operation/unary'
require 'axiom/relation/operation/binary'
require 'axiom/relation/operation/combination'

require 'axiom/relation/operation/limit'
require 'axiom/relation/operation/nest'
require 'axiom/relation/operation/offset'
require 'axiom/relation/operation/order'
require 'axiom/relation/operation/order/direction'
require 'axiom/relation/operation/order/direction_set'
require 'axiom/relation/operation/reverse'
require 'axiom/relation/operation/set'

require 'axiom/algebra/difference'
require 'axiom/algebra/extension'
require 'axiom/algebra/intersection'
require 'axiom/algebra/join'
require 'axiom/algebra/product'
require 'axiom/algebra/projection'
require 'axiom/algebra/rename'
require 'axiom/algebra/rename/aliases'
require 'axiom/algebra/restriction'
require 'axiom/algebra/summarization'
require 'axiom/algebra/summarization/summaries'
require 'axiom/algebra/summarization/summary'
require 'axiom/algebra/union'

require 'axiom/relation/operation/deletion'
require 'axiom/relation/operation/insertion'

require 'axiom-types'
require 'axiom/types/relation'

require 'axiom/attribute/comparable'

require 'axiom/attribute'
require 'axiom/attribute/object'
require 'axiom/attribute/numeric'

require 'axiom/attribute/boolean'
require 'axiom/attribute/class'
require 'axiom/attribute/date'
require 'axiom/attribute/date_time'
require 'axiom/attribute/decimal'
require 'axiom/attribute/float'
require 'axiom/attribute/integer'
require 'axiom/attribute/relation'
require 'axiom/attribute/string'
require 'axiom/attribute/time'

require 'axiom/function/numeric'

require 'axiom/function/numeric/absolute'
require 'axiom/function/numeric/addition'
require 'axiom/function/numeric/division'
require 'axiom/function/numeric/exponentiation'
require 'axiom/function/numeric/modulo'
require 'axiom/function/numeric/multiplication'
require 'axiom/function/numeric/square_root'
require 'axiom/function/numeric/subtraction'
require 'axiom/function/numeric/unary_minus'
require 'axiom/function/numeric/unary_plus'

require 'axiom/function/string/length'

require 'axiom/tuple'
require 'axiom/version'

module Axiom

  # Represent a relation with an empty header and no tuples
  TABLE_DUM = Relation::Empty.new(Relation::Header::EMPTY)

  # Represent a relation with an empty header and a single tuple
  TABLE_DEE = Relation.new(Relation::Header::EMPTY, [EMPTY_ARRAY])

end # module Axiom
