module AddMethodMissing
  def add_method_missing(name = :described_class)
    before do
      # when #optimize delegates to super, it would normally
      # explode, so define method_missing to return self
      send(name).class_eval do
        def method_missing(*)
          self
        end
      end
    end
  end
end
