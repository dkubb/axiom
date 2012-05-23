# encoding: utf-8

module Veritas
  class Relation

    # Allow relations to proxy to other relations
    module Proxy
      include Immutable
      include Equalizer.new(:relation)

      # Relation methods to proxy
      PROXY_METHODS = %w[ header each empty? ].concat(Enumerable.public_instance_methods).freeze

      # Hook called when module is included
      #
      # @param [Module] descendant
      #   the module or class including RelationProxy
      #
      # @return [self]
      #
      # @api private
      def self.included(descendant)
        descendant.class_eval { undef_method *PROXY_METHODS }
      end

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

      # Proxy the message to the relation
      #
      # @param [Symbol] method
      #
      # @param [Array] *args
      #
      # @return [self]
      #   return self for all command methods
      # @return [Object]
      #   return response from all query methods
      #
      # @api private
      def method_missing(method, *args, &block)
        forwardable?(method) ? forward(method, *args, &block) : super
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

      # Forward the message to the relation
      #
      # @param [Array] *args
      #
      # @return [self]
      #   return self for all command methods
      # @return [Object]
      #   return response from all query methods
      #
      # @api private
      def forward(*args, &block)
        relation = self.relation
        response = relation.send(*args, &block)
        if response.equal?(relation)
          self
        else
          response
        end
      end

    end # module Proxy
  end # class Relation
end # module Veritas
