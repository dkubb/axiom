shared_examples_for 'an idempotent method' do
  it 'is idempotent' do
    should equal(instance_eval(&self.class.subject))
  end

  it 'returns a frozen object' do
    case subject
      when Numeric, Symbol, TrueClass, FalseClass, NilClass
        # do nothing, cannot freeze these objects
      else
        should be_frozen
    end
  end
end
