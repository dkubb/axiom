# encoding: utf-8

require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Aliasable, '#inheritable_alias' do
  subject { object.inheritable_alias(aliases) }

  let(:aliases) do
    {
      other: :test,
      other_with_arguments: :test_with_arguments,
      other_with_block:     :test_with_block
    }
  end

  let(:object)    { Class.new(AliasableSpecs::Object) }
  let(:aliasable) { object.new                        }

  it_should_behave_like 'a command method'

  it 'creates a method #other' do
    expect { subject }.to change { aliasable.respond_to?(:other) }
      .from(false)
      .to(true)
  end

  it 'aliases #other to #test' do
    subject
    retval = double('Return Value')
    expect(aliasable).to receive(:test).and_return(retval)
    expect(aliasable.other).to be(retval)
  end

  specification = proc do
    object.class_eval do
      def test
        caller
      end
    end

    subject

    file, line = aliasable.other.first.split(':')[0, 2]

    expect(File.expand_path(file)).to eql(File.expand_path('../../../../../lib/axiom/support/aliasable.rb', __FILE__))

    # Multiple numbers depending on context:
    #
    # 37 for "normal"
    # 39 for "mutation generated code"
    #
    expect([37, 39]).to include(line.to_i)
  end

  it 'sets the file and line number properly' do
    if RUBY_PLATFORM.include?('java')
      pending('Kernel#caller returns the incorrect line number in JRuby', &specification)
    else
      instance_eval(&specification)
    end
  end

  it 'forwards arguments' do
    subject
    expect(aliasable.other_with_arguments(:foo, :bar)).to eql([:foo, :bar])
  end

  it 'forwards block' do
    subject
    block = proc { }
    expect(aliasable.other_with_block(&block)).to eql(block)
  end
end
