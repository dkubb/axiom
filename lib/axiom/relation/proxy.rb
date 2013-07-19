# encoding: utf-8

module Axiom
  class Relation

    # Allow relations to proxy to other relations
    module Proxy
      include Equalizer.new(:relation)

      # Relation methods to proxy
      ENUMERABLE_METHODS = Enumerable.public_instance_methods.map(&:to_s).freeze
      PROXY_METHODS      = %w[ header each empty? materialized? ].freeze
      RELATION_METHODS   = %w[ take drop sort_by ].freeze

      # Hook called when module is included
      #
      # @param [Module] descendant
      #   the module or class including RelationProxy
      #
      # @return [undefined]
      #
      # @api private
      def self.included(descendant)
        descendant.class_eval do
          undef_method(*PROXY_METHODS | ENUMERABLE_METHODS - RELATION_METHODS)
        end
      end

      private_class_method :included

      # The relation that is proxied to
      #
      # @return [Relation]
      #
      # @api private
      attr_reader :relation
      protected :relation

      # Test if the method is supported on this object
      #
      # @param [Symbol] method
      #
      # @return [Boolean]
      #
      # @api private
      def respond_to?(method, *)
        super || forwardable?(method)
      end

    private

      # Forward the message to the relation
      #
      # @param [Array] args
      #
      # @return [self]
      #   return self for all command methods
      # @return [Object]
      #   return response from all query methods
      #
      # @api private
      def method_missing(*args, &block)
        response = relation.public_send(*args, &block)
        if response.equal?(relation)
          self
        else
          response
        end
      end

      # Test if the method can be forwarded to the relation
      #
      # @param [Symbol] method
      #
      # @return [Boolean]
      #
      # @api private
      def forwardable?(method)
        relation.respond_to?(method)
      end

    end # module Proxy
  end # class Relation
end # module Axiom
