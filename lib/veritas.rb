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

require 'veritas/logic'
require 'veritas/relation'
require 'veritas/algebra'

require 'veritas/optimizer'
require 'veritas/attribute'
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
