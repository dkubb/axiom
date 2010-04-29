require File.expand_path('../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Aliasable#inheritable_alias' do
  before do
    @klass     = Class.new(AliasableSpecs::Object)
    @aliasable = @klass.new

    @aliases = { :test => :other }
  end

  subject { @klass.inheritable_alias(@aliases) }

  it 'should return the class' do
    should equal(@klass)
  end

  it 'should create a method #other' do
    @aliasable.should_not respond_to(:other)
    subject
    @aliasable.should respond_to(:other)
  end

  it 'should alias #other to #test' do
    subject
    retval = mock('Return Value')
    @aliasable.should_receive(:test).and_return(retval)
    @aliasable.other.should equal(retval)
  end

  specification = proc do
    @klass.class_eval do
      def test
        caller
      end
    end

    subject

    @aliasable.other.first.split(':')[0, 2].should == [  File.expand_path('../../../../../lib/veritas/support/aliasable.rb', __FILE__), '7' ]
  end

  it 'should set the file and line number' do
    if RUBY_PLATFORM[/java/]
      pending('Kernel#caller returns the incorrect line number in JRuby', &specification)
    else
      instance_eval(&specification)
    end
  end
end
