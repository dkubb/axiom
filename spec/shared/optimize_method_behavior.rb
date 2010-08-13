shared_examples_for 'an optimize method' do
  it_should_behave_like 'an idempotent method'

  it 'does not optimize further' do
    optimized = subject
    optimized.optimize.should equal(optimized)
  end

  it 'returns an optimized object' do
    should be_optimized
  end
end
