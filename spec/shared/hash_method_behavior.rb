# encoding: utf-8

shared_examples_for 'a hash method' do
  it_should_behave_like 'an idempotent method'

  it { should be_instance_of(Fixnum) }

  it 'memoizes the hash code' do
    subject.should eql(object.memoized(:hash))
  end
end
