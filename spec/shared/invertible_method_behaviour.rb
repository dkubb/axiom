# encoding: utf-8

shared_examples_for 'an invertible method' do
  it_should_behave_like 'an idempotent method'

  it 'is invertible' do
    expect(subject.inverse).to be(object)
  end
end
