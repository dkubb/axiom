module Veritas
  module AbstractClass
    def self.included(descendant)
      descendant.instance_eval <<-RUBY, __FILE__, __LINE__
        def new(*)
          if self == #{descendant}
            raise NotImplementedError, '#{descendant} is an abstract class'
          else
            super
          end
        end
      RUBY
    end

  end # module AbstractClass
end # module Veritas
