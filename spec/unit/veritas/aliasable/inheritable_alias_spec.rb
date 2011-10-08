# encoding: utf-8

require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Aliasable, '#inheritable_alias' do
  subject { object.inheritable_alias(aliases) }

  let(:aliases)   { { :other => :test }               }
  let(:object)    { Class.new(AliasableSpecs::Object) }
  let(:aliasable) { object.new                        }

  it_should_behave_like 'a command method'

  it 'creates a method #other' do
    expect { subject }.to change { aliasable.respond_to?(:other) }.
      from(false).
      to(true)
  end

  it 'aliases #other to #test' do
    subject
    retval = mock('Return Value')
    aliasable.should_receive(:test).and_return(retval)
    aliasable.other.should equal(retval)
  end

  specification = proc do
    object.class_eval do
      def test
        caller
      end
    end

    subject

    file, line = aliasable.other.first.split(':')[0, 2]

    File.expand_path(file).should eql(File.expand_path('../../../../../lib/veritas/support/aliasable.rb', __FILE__))
    line.to_i.should eql(38)
  end

  it 'sets the file and line number properly' do
    if RUBY_PLATFORM.include?('java')
      pending('Kernel#caller returns the incorrect line number in JRuby', &specification)
    else
      instance_eval(&specification)
    end
  end
end
