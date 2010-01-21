require 'set'

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
  class OrderedRelationRequiredError < StandardError; end
  class RelationMismatchError < StandardError; end

  TABLE_DEE = Relation.new([], [ [] ])
  TABLE_DUM = Relation::Empty.new([])
end
