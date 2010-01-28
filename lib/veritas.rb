require 'set'
require 'singleton'

require 'veritas/support/abstract_class'
require 'veritas/support/operation/binary'
require 'veritas/support/optimizable'

require 'veritas/relation'
require 'veritas/algebra'

require 'veritas/attribute'
require 'veritas/tuple'
require 'veritas/version'

module Veritas
  class InvalidHeaderError < ArgumentError; end
  class InvalidOffsetError < ArgumentError; end
  class OrderedRelationRequiredError < StandardError; end
  class RelationMismatchError < StandardError; end

  TABLE_DUM = Relation.new([], [    ]).optimize
  TABLE_DEE = Relation.new([], [ [] ]).optimize
end
