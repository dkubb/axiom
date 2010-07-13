require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Aliasable#inheritable_alias' do
  subject { klass.inheritable_alias(aliases) }

  let(:klass)     { Class.new(AliasableSpecs::Object) }
  let(:aliasable) { klass.new                         }
  let(:aliases)   { { :other => :test }               }

  it 'returns the class' do
    should equal(klass)
  end

  it 'creates a method #other' do
    expect { subject }.to change { aliasable.respond_to?(:other) }.from(false).to(true)
  end

  it 'aliases #other to #test' do
    subject
    retval = mock('Return Value')
    aliasable.should_receive(:test).and_return(retval)
    aliasable.other.should equal(retval)
  end

  specification = proc do
    klass.class_eval do
      def test
        caller
      end
    end

    subject

    aliasable.other.first.split(':')[0, 2].should == [  File.expand_path('../../../../../lib/veritas/support/aliasable.rb', __FILE__), '7' ]
  end

  it 'sets the file and line number properly' do
    if RUBY_PLATFORM[/java/]
      pending('Kernel#caller returns the incorrect line number in JRuby', &specification)
    else
      instance_eval(&specification)
    end
  end
end
