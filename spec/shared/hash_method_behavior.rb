# encoding: utf-8

shared_examples_for 'a hash method' do
  it_should_behave_like 'an idempotent method'

  specification = lambda do
    should be_instance_of(Fixnum)
  end

  it 'is a fixnum' do
    if defined?(RUBY_ENGINE) && RUBY_ENGINE == 'rbx'
      pending('Under rubinius #hash does not always use a Fixnum', &specification)
    else
      instance_eval(&specification)
    end
  end

  it 'memoizes the hash code' do
    subject.should eql(object.memoized(:hash))
  end
end
