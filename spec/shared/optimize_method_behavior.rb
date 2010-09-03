shared_examples_for 'an optimize method' do
  it_should_behave_like 'an idempotent method'

  it 'does not optimize further' do
    optimized = subject
    optimized.optimize.should equal(optimized)
  end

  it 'it memoizes itself for #optimize' do
    optimized = subject
    optimized.memoized('optimize').should equal(optimized)
  end
end
