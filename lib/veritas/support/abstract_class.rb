module Veritas
  module AbstractClass
    def self.included(klass)
      klass.instance_eval <<-RUBY, __FILE__, __LINE__
        def new(*)
          if self == #{klass}
            raise NotImplementedError, '#{klass} is an abstract class'
          else
            super
          end
        end
      RUBY
    end

  end # module AbstractClass
end # module Veritas
