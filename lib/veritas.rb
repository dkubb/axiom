require 'bigdecimal'
require 'date'
require 'set'
require 'singleton'

require 'veritas/core_ext/date'
require 'veritas/core_ext/range'
require 'veritas/core_ext/time'

require 'veritas/support/abstract_class'
require 'veritas/support/aliasable'
require 'veritas/support/immutable'
require 'veritas/support/optimizable'
require 'veritas/support/visitable'

require 'veritas/support/operation/binary'
require 'veritas/support/operation/unary'

require 'veritas/support/evaluator'

require 'veritas/logic/expression'
require 'veritas/logic/connective'
require 'veritas/logic/connective/binary'
require 'veritas/logic/connective/unary'
require 'veritas/logic/connective/conjunction'
require 'veritas/logic/connective/disjunction'
require 'veritas/logic/connective/negation'

require 'veritas/logic/predicate'
require 'veritas/logic/predicate/comparable'
require 'veritas/logic/predicate/enumerable'
require 'veritas/logic/predicate/equality'
require 'veritas/logic/predicate/exclusion'
require 'veritas/logic/predicate/greater_than'
require 'veritas/logic/predicate/greater_than_or_equal_to'
require 'veritas/logic/predicate/inclusion'
require 'veritas/logic/predicate/inequality'
require 'veritas/logic/predicate/less_than'
require 'veritas/logic/predicate/less_than_or_equal_to'
require 'veritas/logic/predicate/no_match'
require 'veritas/logic/predicate/match'

require 'veritas/logic/proposition'
require 'veritas/logic/proposition/false'
require 'veritas/logic/proposition/true'

require 'veritas/relation'

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
require 'veritas/algebra/union'

require 'veritas/optimizer'

require 'veritas/optimizer/relation/materialized'

require 'veritas/optimizer/relation/operation/binary'
require 'veritas/optimizer/relation/operation/unary'
require 'veritas/optimizer/relation/operation/combination'
require 'veritas/optimizer/relation/operation/limit'
require 'veritas/optimizer/relation/operation/offset'
require 'veritas/optimizer/relation/operation/order'
require 'veritas/optimizer/relation/operation/reverse'

require 'veritas/optimizer/algebra/difference'
require 'veritas/optimizer/algebra/extension'
require 'veritas/optimizer/algebra/intersection'
require 'veritas/optimizer/algebra/join'
require 'veritas/optimizer/algebra/product'
require 'veritas/optimizer/algebra/projection'
require 'veritas/optimizer/algebra/rename'
require 'veritas/optimizer/algebra/restriction'
require 'veritas/optimizer/algebra/summarization'
require 'veritas/optimizer/algebra/union'

require 'veritas/optimizer/logic/connective/binary'
require 'veritas/optimizer/logic/connective/conjunction'
require 'veritas/optimizer/logic/connective/disjunction'
require 'veritas/optimizer/logic/connective/negation'

require 'veritas/optimizer/logic/predicate'
require 'veritas/optimizer/logic/predicate/comparable'
require 'veritas/optimizer/logic/predicate/enumerable'
require 'veritas/optimizer/logic/predicate/equality'
require 'veritas/optimizer/logic/predicate/exclusion'
require 'veritas/optimizer/logic/predicate/greater_than'
require 'veritas/optimizer/logic/predicate/greater_than_or_equal_to'
require 'veritas/optimizer/logic/predicate/inequality'
require 'veritas/optimizer/logic/predicate/inclusion'
require 'veritas/optimizer/logic/predicate/less_than'
require 'veritas/optimizer/logic/predicate/less_than_or_equal_to'

require 'veritas/attribute'
require 'veritas/attribute/orderable'
require 'veritas/attribute/comparable'
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

require 'veritas/tuple'
require 'veritas/version'

module Veritas

  # Raised when the headers are invalid for Join and Product
  class InvalidHeaderError < ArgumentError; end

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

  # Raised when an attribute is added to a relation that already exists
  class DuplicateHeaderName < StandardError; end

  TABLE_DUM = Relation.new([], [    ]).optimize
  TABLE_DEE = Relation.new([], [ [] ]).optimize
end
