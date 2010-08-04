module Veritas
  module Logic
    class Proposition < Expression
      include Singleton

      def self.new(*args)
        if args.empty?
          super
        else
          (args.first ? True : False).instance
        end
      end

      def call(*)
        self.class.eval
      end

      def complement
        self.class.complement.instance
      end

      def eql?(other)
        instance_of?(other.class)
      end

      def inspect
        call.inspect
      end

      def hash
        call.hash
      end

    end # class Proposition
  end # module Algebra
end # module Veritas

require 'veritas/logic/proposition/false'
require 'veritas/logic/proposition/true'
