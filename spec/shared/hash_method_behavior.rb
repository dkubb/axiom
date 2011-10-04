# encoding: utf-8

shared_examples_for 'a hash method' do
  it_should_behave_like 'an idempotent method'

  # TOOD: figure out if #hash under rbx should also always use Fixnum
  if defined?(RUBY_ENGINE) && RUBY_ENGINE == 'rbx'
    it { should be_kind_of(Integer) }
  else
    it { should be_instance_of(Fixnum) }
  end

  it 'memoizes the hash code' do
    subject.should eql(object.memoized(:hash))
  end
end
