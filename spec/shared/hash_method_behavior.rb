shared_examples_for 'a hash method' do
  it_should_behave_like 'an idempotent method'

  it { should be_kind_of(Fixnum) }
end
